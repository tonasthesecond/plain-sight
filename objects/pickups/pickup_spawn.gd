class_name PickupSpawn
extends Node2D
## A position where pickups spawn periodically.

@export var spawn_interval := Vector2(5.0, 10.0)
@export var possible_spawns: Array[Pickup]

@onready var spawn_timer: Timer = $SpawnTimer

var pickup_object_scene: PackedScene = preload("uid://e5nie8wuhhuy")
var spawned_pickup: PickupObject

func _process(_delta: float) -> void:
    if spawned_pickup: return
    if not spawn_timer.is_stopped(): return

    spawned_pickup = pickup_object_scene.instantiate() as PickupObject
    spawned_pickup.pickup = Utils.select_random_item(possible_spawns) as Pickup
    spawned_pickup.interacted.connect(
        spawn_timer.start.bind(Utils.get_random_float_from_range(spawn_interval))
        )
    add_child(spawned_pickup)
    