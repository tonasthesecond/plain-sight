extends CharacterBody2D
class_name Player

signal died

@export_enum("player1", "player2") var player_id: String = "player1"
@onready var sprite: Sprite2D = $Sprite
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var attack_delay_timer: Timer = $AttackDelayTimer

var weapon: PackedScene = preload("uid://ch81l6u6bc3tg")
var previous_direction: Vector2 = Vector2.RIGHT

var state_machine: StateMachine
var move_state: MoveState

func _ready() -> void:
    state_machine = StateMachine.new()
    move_state = MoveState.new(Settings.WALK_SPEED, PlayerInputMovementProvider.new(player_id))
    
    var anim_move_state = AnimatedState.new(
        move_state,
        "", "walk", "",
        animation_component
    )
    var anim_idle_state = AnimatedState.new(
        IdleState.new(),
        "", "idle", "",
        animation_component
    )

    state_machine.init(
        self, [anim_idle_state, anim_move_state],
        func(): return {
            "is_idling": move_state.movement_provider.get_movement_vector() == Vector2.ZERO
        },
        [
            StateTransition.new(anim_move_state, anim_idle_state, ["is_idling"]),
            StateTransition.new(anim_idle_state, anim_move_state, ["!is_idling"])
        ]
    )

    sprite.modulate = Utils.get_random_predefined_color()

func _physics_process(delta: float) -> void:
    state_machine.physics_process(delta)

    if move_state.movement_provider.get_movement_vector() != Vector2.ZERO:
        previous_direction = move_state.movement_provider.get_movement_vector()

    # Attacking
    if Input.is_action_just_pressed(player_id + "_attack") and attack_delay_timer.is_stopped():
        attack_delay_timer.start()
        var weapon_instance = weapon.instantiate()
        weapon_instance.position = previous_direction * Vector2(8, 8)
        weapon_instance.rotation = previous_direction.angle()
        add_child(weapon_instance)

func _on_damage_area_component_damaged(_damager: Node2D) -> void:
    print(player_id + " died")
    died.emit()
