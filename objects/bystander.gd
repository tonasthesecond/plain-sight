extends CharacterBody2D
class_name Bystander

@export var ai_type: AIType
@onready var ai_override_detector: Area2D = $AIOverrideDetector
@onready var walk_timer: Timer = $WalkTimer
@onready var wait_timer: Timer = $WaitTimer
@onready var movement_component: MovementComponent = $MovementComponent
@onready var animation_component: AnimationComponent = $AnimationComponent

var movement_package: AIMovementPackage

var ai_select_trials_limit: int = 10

func _physics_process(_delta: float) -> void:
    # If stopped waiting and walking, get new instructions from AI
    if walk_timer.is_stopped() and wait_timer.is_stopped():
        
        var valid_move: bool = false
        while not valid_move:
            # Get random AI
            var chosen_ai_type: AIType = select_random_ai_type()

            # Make sure the direction chosen has no collision
            var ai_select_trials_count: int = 0
            movement_package = chosen_ai_type.get_movement_package()
            while movement_component.move(movement_package.direction) and ai_select_trials_count <= ai_select_trials_limit:
                movement_package = chosen_ai_type.get_movement_package()
                ai_select_trials_count += 1
            
            # Check whether a valid move was chosen, else, repeat AI selection
            valid_move = ai_select_trials_count <= ai_select_trials_limit

        # Start moving
        walk_timer.start(movement_package.walk_time)

    # When moving
    if not walk_timer.is_stopped():
        var collided = movement_component.move(movement_package.direction)

        # If collides then stop moving
        if collided: 
            walk_timer.stop()
            _on_walk_timer_timeout()
    
    else: move_and_collide(Vector2.ZERO) # This is to keep the collision active and working
    
    # Animate
    if movement_package.direction.length() > 0:
        animation_component.play_animation("walk")
    else:
        animation_component.play_animation("idle")
    
func _on_walk_timer_timeout() -> void:
    wait_timer.start(movement_package.wait_time)
    movement_package.direction = Vector2.ZERO

func _on_damage_area_component_damaged() -> void:
    set_physics_process(false)

    animation_component.stop_animation()
    animation_component.play_animation(["die_right", "die_left"][randi() % 2])
    animation_component.animation_finished.connect(func(): queue_free())

func select_random_ai_type() -> AIType:
    # Get current AIMovementPackage provider options
    var ai_provider_options: Array[AIType]
    for area in ai_override_detector.get_overlapping_areas():
        if area is AIOverrideArea:
            for iteration in range(area.probability * 10):
                ai_provider_options.append(area.ai_type)
    
    ai_provider_options.append(ai_type) # Append default AI so it doesn't get stuck
    # Fill with default AI if not enough overrides
    while ai_provider_options.size() < 10:
        ai_provider_options.append(ai_type)

    return ai_provider_options[randi() % ai_provider_options.size()]