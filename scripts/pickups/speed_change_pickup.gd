class_name IncreaseSpeedPickup
extends Pickup

@export var speed_multiplier: float = 2

func _init(_speed_multiplier: float = speed_multiplier) -> void:
    name = "Speed Increase"
    speed_multiplier = _speed_multiplier

func pick_up(player: Player) -> void:
    player.move_state.speed *= speed_multiplier
