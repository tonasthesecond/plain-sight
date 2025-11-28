class_name AIMovementProvider
extends MovementProvider

@export var ai_type: AIType
@export var move_timer: Timer
@export var target_node: CharacterBody2D

func _init(
    _target_node: CharacterBody2D,
    _ai_type: AIType, 
    _move_timer: Timer, 
) -> void:
    target_node = _target_node
    ai_type = _ai_type
    move_timer = _move_timer
    new_vector = ai_type.get_movement_package().direction

func get_movement_vector() -> Vector2:
    if move_timer.is_stopped():
        # Make sure there are no collisions, prevents continuously walking into wall
        while target_node.move_and_collide(last_vector, true):
            new_vector = ai_type.get_movement_package().direction
        
        # Return last_vector to prevent jittering from sudden vector change
        return last_vector

    # Make sure there are no collisions, prevents continuously walking into wall
    while target_node.move_and_collide(new_vector, true):
        new_vector = ai_type.get_movement_package().direction
    return new_vector
