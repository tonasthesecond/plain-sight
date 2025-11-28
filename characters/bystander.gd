extends CharacterBody2D
class_name Bystander

@export var ai_type: AIType

@onready var ai_override_detector: Area2D = $AIOverrideDetector
@onready var sprite: Sprite2D = $Sprite
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var move_timer: Timer = $MoveTimer
@onready var idle_timer: Timer = $IdleTimer

var ai_movement_provider: AIMovementProvider
var ai_select_trials_limit: int = 10
var state_machine: StateMachine

var move_state: MoveState

func _ready() -> void:
    ai_movement_provider = AIMovementProvider.new(
        self,
        ai_type, 
        move_timer,
        )

    move_state = MoveState.new(Settings.WALK_SPEED, ai_movement_provider)
    var anim_move_state = AnimatedState.new(
        move_state,
        "", "walk", "",
        animation_component
        )
    var anim_idle_state := AnimatedState.new(
        IdleState.new(), 
        "", "default", "", 
        animation_component
        ) 

    state_machine = StateMachine.new()
    state_machine.init(
        self, [anim_idle_state, anim_move_state],
        func(): 
            return {
                "is_moving": not move_timer.is_stopped(),
                "is_idling": not idle_timer.is_stopped(),
            },
        [
            StateTransition.new(anim_move_state, anim_idle_state, ["is_idling"]), 
            StateTransition.new(anim_idle_state, anim_move_state, ["is_moving"])
        ]
        )

    sprite.modulate = Utils.get_random_predefined_color()

    move_timer.timeout.connect(func(): idle_timer.start(ai_type.get_movement_package().idle_time))
    idle_timer.timeout.connect(func(): move_timer.start(ai_type.get_movement_package().move_time))
    move_timer.start(Settings.AI_WALK_TIME_BOUNDS.y * randf_range(0.0, 2.0))

func _physics_process(delta: float) -> void:
    state_machine.physics_process(delta)
    ai_movement_provider = AIMovementProvider.new(
        self,
        select_random_ai_type(), 
        move_timer, 
        )

func _on_damage_area_component_damaged(_damager: Node2D) -> void:
    set_physics_process(false)

    animation_component.stop_animation()
    animation_component.play_animation(["die_right", "die_left"][randi() % 2])
    animation_component.animation_finished.connect(func(_anim_name): queue_free())

func select_random_ai_type() -> AIType:
    # Get current AIMovementPackage provider options
    var ai_provider_options: Array[AIType]
    var weights: Array[float]

    for area in ai_override_detector.get_overlapping_areas():
        if not area is AIOverrideArea: continue
        ai_provider_options.append(area.ai_type)
        weights.append(area.weight)
    
    ai_provider_options.append(ai_type) # Append default AI so it doesn't get stuck
    weights.append(1.0)

    return Utils.select_random_item(ai_provider_options, weights)
