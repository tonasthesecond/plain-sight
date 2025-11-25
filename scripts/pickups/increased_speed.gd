extends Pickup

func pick_up(player: Player) -> void:
    player.movement_component.SPEED *= 2

