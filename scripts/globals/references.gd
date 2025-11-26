extends Node

var player1: Player
var player2: Player

func _ready() -> void:
    await get_tree().process_frame
    for player: Player in get_tree().get_nodes_in_group("player"):
        if player.player_id == "player1":
            player1 = player
        else:
            player2 = player
