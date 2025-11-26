class_name MoveState
extends State

var speed: float
var movement_provider: MovementProvider
var enter_animation_name: String

func _init(
    _speed: float, 
    _movement_provider: MovementProvider,
) -> void:
    speed = _speed
    movement_provider = _movement_provider

func physics_process(delta: float) -> void:
    # Get the movement vector
    var movement_vector = movement_provider.get_movement_vector()

    if movement_vector != Vector2.ZERO:
        if "acceleration_smoothing_factor" in data:
            target_node.velocity = Utils.standard_lerp(
                target_node.velocity, 
                movement_vector * speed,
                data["acceleration_smoothing_factor"],
                delta
            )
        else:
            target_node.velocity = movement_vector * speed
    else:
        if "deceleration_smoothing_factor" in data:
            target_node.velocity = Utils.standard_lerp(
                target_node.velocity, 
                Vector2.ZERO,
                data["deceleration_smoothing_factor"],
                delta
            )
        else:
            target_node.velocity = Vector2.ZERO
    target_node.move_and_slide()
