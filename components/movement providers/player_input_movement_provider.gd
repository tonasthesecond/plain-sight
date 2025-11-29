class_name PlayerInputMovementProvider
extends MovementProvider

var player_id: int 

func _init(_player_id: int) -> void:
    player_id = _player_id

func get_movement_vector() -> Vector2:
    new_vector = Input.get_vector(
        Settings.PLAYER_STRING_IDS[player_id] + "_left", 
        Settings.PLAYER_STRING_IDS[player_id] + "_right", 
        Settings.PLAYER_STRING_IDS[player_id] + "_up", 
        Settings.PLAYER_STRING_IDS[player_id] + "_down"
    )
    return new_vector
