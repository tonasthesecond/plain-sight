@abstract class_name Pickup
extends Resource

var name: String = "Mysterious Pickup"

@abstract func _init() -> void
@abstract func apply_pickup(player: Player) -> void

func pick_up(player: Player) -> void:
    apply_pickup(player)
    MessageSystem.queue_priority_message(Settings.PLAYER_NAMES[player.player_id] + " picked up " + name)
