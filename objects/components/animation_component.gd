class_name AnimationComponent
extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    animation_player.animation_finished.connect(func(_anim_name: String): animation_finished.emit())

func play_animation(animation_name: String) -> void:
    if animation_name in sprite_frames.get_animation_names():
        play(animation_name)
    else:
        play("default")

    if animation_player.has_animation(animation_name):
        animation_player.play(animation_name)
    else:
        animation_player.stop()

func stop_animation() -> void:
    stop()
    animation_player.stop()
