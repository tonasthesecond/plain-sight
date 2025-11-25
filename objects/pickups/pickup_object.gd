extends Node2D


@export var pickup: Pickup

@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var pickup_area: Area2D = $AnimationComponent/PickupArea


func _ready() -> void:
    animation_component.play_animation("float")


func _unhandled_input(event: InputEvent) -> void:

    # Get all colliding players
    var colliding_players: Array
    for colliding_objects in Functions.get_colliding_objects_of_area(pickup_area):
        colliding_players.append(colliding_objects["collider"])

    # Check input and trigger pick up function
    if colliding_players:
        if event.is_action("player1_interact") and References.player1 in colliding_players: 
            pickup.pick_up(References.player1)
            queue_free()
        elif event.is_action("player2_interact") and References.player2 in colliding_players: 
            pickup.pick_up(References.player2)
            queue_free()
