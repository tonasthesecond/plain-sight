extends Node2D

@export var pickup: Pickup

@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var pickup_area: Area2D = $AnimationComponent/PickupArea

func _ready() -> void:
    animation_component.play_animation("float")

func _unhandled_input(event: InputEvent) -> void:

    # Get all colliding players
    var colliding_players: Array
    for colliding_objects in Utils.get_colliders_from_object(pickup_area):
        colliding_players.append(colliding_objects["collider"])

    # Check input and trigger pick up function
    if colliding_players:
        if event.is_action("player1_interact") and Refs.player1 in colliding_players: 
            pickup.pick_up(Refs.player1)
            queue_free()
        elif event.is_action("player2_interact") and Refs.player2 in colliding_players: 
            pickup.pick_up(Refs.player2)
            queue_free()
