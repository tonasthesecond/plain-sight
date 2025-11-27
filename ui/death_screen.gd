extends Control

func _ready() -> void:
    await get_tree().process_frame
    Refs.player1.died.connect(
        func(): 
            show()
            print("player 2 wins")
            $AnimationPlayer.play("stab")
            )

    Refs.player2.died.connect(
        func(): 
            show()
            print("player 1 wins")
            $AnimationPlayer.play("stab")
            )
