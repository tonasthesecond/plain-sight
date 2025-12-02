extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attacking_player_sprite: Sprite2D = $AttackingPlayer
@onready var attacked_player_sprite: Sprite2D = $AttackedPlayer
@onready var attacking_player_label: Label = $AttackingPlayerLabel
@onready var attacked_player_label: Label = $AttackedPlayerLabel

func _ready() -> void:
    await get_tree().process_frame
    if not Refs.player1 or not Refs.player2: return
    Refs.player1.died.connect(play_death_animation.bind(
        "stab", 
        Refs.player2, 
        Refs.player1
    ))
    Refs.player2.died.connect(play_death_animation.bind(
        "stab", 
        Refs.player1, 
        Refs.player2
    ))

func play_death_animation(
    anim_name: String, 
    attacking_player: Player,
    attacked_player: Player
) -> void:
    show()
    attacking_player.set_physics_process(false)
    attacked_player.set_physics_process(false)
    
    var _attacked_player_sprite: Sprite2D = attacked_player.get_node("Sprite")
    var _attacking_player_sprite: Sprite2D = attacking_player.get_node("Sprite")
    
    # Update labels
    attacking_player_label.text = Settings.PLAYER_NAMES[attacking_player.player_id]
    attacked_player_label.text = Settings.PLAYER_NAMES[attacked_player.player_id]

    # Copy properties to the placeholder sprites
    attacked_player_sprite.texture = _attacked_player_sprite.texture
    attacked_player_sprite.modulate = _attacked_player_sprite.modulate

    attacking_player_sprite.texture = _attacking_player_sprite.texture
    attacking_player_sprite.modulate = _attacking_player_sprite.modulate
    
    # Update first keyframe
    Utils.set_keyframe(
        animation_player, anim_name, 
        "AttackedPlayer:modulate", 0,
        attacked_player_sprite.modulate
    )
    
    animation_player.play(anim_name)
