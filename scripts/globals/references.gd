extends Node

var level_node: Level
var player1: Player
var player2: Player
var message_bar: MessageBar

func _ready() -> void:
    await get_tree().process_frame
    for player: Player in get_tree().get_nodes_in_group("player"):
        if player.player_id == "player1":
            player1 = player
        else:
            player2 = player

    level_node = get_tree().get_first_node_in_group("level")
    if not level_node: return
    message_bar = level_node.get_node("UI/MessageBar")
