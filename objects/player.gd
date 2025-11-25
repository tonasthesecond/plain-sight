extends CharacterBody2D
class_name Player

@export_enum("player1", "player2") var player_id: String = "player1"
@onready var movement_component: MovementComponent = $MovementComponent
@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var attack_delay_timer: Timer = $AttackDelayTimer

var weapon: PackedScene = preload("res://objects/weapon.tscn")

var previous_direction: Vector2 = Vector2.RIGHT
var input_frames_timer: int = 0
var input_frames_buffer: int = 1

func _physics_process(_delta: float) -> void:
    ## Movement
    var direction: Vector2 = Input.get_vector(
        player_id + "_left",
        player_id + "_right",
        player_id + "_up",
        player_id + "_down"
    )

    # Bypass buffer if stopping
    if direction == Vector2.ZERO:
        input_frames_timer = input_frames_buffer
    else:
        # Count input frames
        if previous_direction != direction:
            input_frames_timer = 0
            previous_direction = direction
        else:
            input_frames_timer += 1

    # Move if input has been held for a certain amount of frames
    if input_frames_timer >= input_frames_buffer:
        if direction != Vector2.ZERO:
            previous_direction = direction
        movement_component.move(direction)

    ## Attacking
    if Input.is_action_just_pressed(player_id + "_attack") and attack_delay_timer.is_stopped():
        attack_delay_timer.start()
        var weapon_instance = weapon.instantiate()
        weapon_instance.position = previous_direction * Vector2(8, 8)
        weapon_instance.rotation = previous_direction.angle()
        add_child(weapon_instance)

    ## Animations
    if direction != Vector2.ZERO:
        animation_component.play_animation("walk")
    else:
        animation_component.play_animation("idle")

func _on_damage_area_component_damaged() -> void:
    print(player_id + " died")
