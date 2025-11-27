class_name PickupObject
extends Node2D

signal interacted

@export var pickup: Pickup

@onready var animation: AnimationComponent = $AnimationComponent
@onready var damage_area: DamageAreaComponent = $DamageAreaComponent
@onready var pickup_area: Area2D = $AnimationComponent/PickupArea

const FADE_IN_RATE: float = 1 # Opacity change per second

func _ready() -> void:
    animation.play_animation("float")
    damage_area.damaged.connect(on_interacted)

    modulate.a = 0
    get_tree().create_tween().tween_property(
        self, "modulate:a",
        1,
        1 / FADE_IN_RATE
        )

func _unhandled_input(_event: InputEvent) -> void:
    # Get all colliding players
    var colliding_players: Array
    for colliding_objects in Utils.get_colliders_from_object(pickup_area):
        colliding_players.append(colliding_objects["collider"])

func on_interacted(interactor: Node2D) -> void:
    if interactor is Player:
        interacted.emit()
        pickup.pick_up(interactor)
        queue_free()
