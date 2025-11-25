extends Node
class_name SpawnManager

@export var number_of_bystanders: int = 100
@export var bystander_canvas_group: CanvasGroup

@onready var bystander_scene: PackedScene = preload("res://objects/bystander.tscn")
@onready var player_scene: PackedScene = preload("res://objects/player.tscn")
@onready var validation_area: Area2D = $ValidationArea
@onready var player_collision_shape: CollisionShape2D = $ValidationArea/PlayerCollisionShape

func _ready() -> void:
    for i in range(number_of_bystanders):
        spawn_bystander()
    spawn_player("player1")
    spawn_player("player2")
    
func spawn_bystander() -> void:
    var new_bystander: Bystander = bystander_scene.instantiate()

    # Get random AI
    var ai_directory: Array[String]
    ai_directory.assign(DirAccess.open("res://scripts/ais").get_files())
    ai_directory = ai_directory.filter(
        func(file_name: String) -> bool:
            return file_name.ends_with(".gd")
    )
    var ai_script = load("res://scripts/ais/" + ai_directory[randi() % ai_directory.size()])
    new_bystander.ai_type = ai_script.new()

    # Make sure spawn doesn't collide
    validation_area.position = get_random_position()
    while area_is_colliding(validation_area):
        validation_area.position = get_random_position()

    # Spawn
    new_bystander.position = validation_area.position
    bystander_canvas_group.add_child(new_bystander)

func spawn_player(player_id: String) -> void:
    # Create new player with id
    var new_player: Player = player_scene.instantiate()
    new_player.player_id = player_id
    
    # Make sure spawn doesn't collide
    validation_area.position = get_random_position()
    while area_is_colliding(validation_area):
        validation_area.position = get_random_position()
    
    # Spawn
    new_player.position = validation_area.position
    bystander_canvas_group.add_child(new_player)

func get_random_position() -> Vector2:
    return Vector2(
        randf() * get_viewport().get_visible_rect().size.x, 
        randf() * get_viewport().get_visible_rect().size.y
    )

func area_is_colliding(area: Area2D) -> bool:
    # Get query parameters
    var collision_shape: CollisionShape2D = area.get_child(0)
    var world_space_state = owner.get_world_2d().get_direct_space_state()

    var collision_query = PhysicsShapeQueryParameters2D.new()
    collision_query.shape = collision_shape.shape
    collision_query.transform = collision_shape.global_transform
    collision_query.collision_mask = area.collision_mask

    # Check and return query results
    return world_space_state.intersect_shape(collision_query).size() > 0
