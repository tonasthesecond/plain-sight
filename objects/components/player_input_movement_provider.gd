class_name PlayerInputMovementProvider
extends MovementProvider

var player_id: String 

func _init(_player_id: String) -> void:
    player_id = _player_id

func get_movement_vector() -> Vector2:
    new_vector = Input.get_vector(
        player_id + "_left", 
        player_id + "_right", 
        player_id + "_up", 
        player_id + "_down"
    )
    return new_vector
