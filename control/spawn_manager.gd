class_name SpawnManager
extends Node
## Manages spawning of bystanders and players.

@export var number_of_bystanders: int = 100
@export var characters_container: Node
@export var possible_ai: Array[AIType]

@onready var bystander_scene: PackedScene = preload("uid://c7jv8e4j0u13p")
@onready var player_scene: PackedScene = preload("uid://im7dvn01s5ui")
@onready var player_collision_shape_scene: PackedScene = preload("uid://voersvek38s5")

var validation_area: Area2D

func _ready() -> void:
    # Setup validation area
    validation_area = Area2D.new()
    validation_area.add_child(player_collision_shape_scene.instantiate())
    
    add_child(validation_area)

    # Spawn bystanders
    for i in range(number_of_bystanders):
        spawn_bystander()

    # Spawn players
    spawn_player("player1")
    spawn_player("player2")
    
func spawn_bystander() -> void:
    # Create new bystander with random AI
    var new_bystander: Bystander = bystander_scene.instantiate()
    new_bystander.ai_type = Utils.select_random_item(possible_ai)

    # Spawn
    new_bystander.position = get_valid_position()
    characters_container.add_child(new_bystander)

func spawn_player(player_id: String) -> void:
    # Create new player with id
    var new_player: Player = player_scene.instantiate()
    new_player.player_id = player_id
    
    # Spawn
    new_player.position = get_valid_position()
    characters_container.add_child(new_player)

func get_valid_position() -> Vector2:
    validation_area.position = get_random_position()
    while Utils.get_colliders_from_object(validation_area):
        validation_area.position = get_random_position()
    return validation_area.position

func get_random_position() -> Vector2:
    return Vector2(
        randf() * get_viewport().get_visible_rect().size.x, 
        randf() * get_viewport().get_visible_rect().size.y
    )
