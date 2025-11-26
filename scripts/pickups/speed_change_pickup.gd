class_name IncreaseSpeedSpeed
extends Pickup

@export var speed_multiplier: float = 2

func pick_up(player: Player) -> void:
    player.move_state.SPEED *= speed_multiplier

