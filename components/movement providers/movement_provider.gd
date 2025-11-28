@abstract class_name MovementProvider
extends Node
## This class is the base class for all movement providers.
## Movement providers work by changing new_vector.

var last_vector := Vector2.ZERO
var new_vector := Vector2.ZERO :
    set = set_new_vector

@abstract func get_movement_vector() -> Vector2

func set_new_vector(_new_vector: Vector2) -> void:
    if new_vector != Vector2.ZERO:
        last_vector = new_vector
    new_vector = _new_vector 

func get_animation_direction() -> Vector2:
    # If moving, use movement direction
    if new_vector != Vector2.ZERO:
        last_vector = new_vector
        return new_vector
    
    # If not moving, use last pressed direction
    return last_vector

func is_stopped() -> bool:
    return get_movement_vector().is_zero_approx()