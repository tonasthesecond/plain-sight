extends Node



# Get colliding area
func get_colliding_objects_of_area(area: Area2D) -> Array[Dictionary]:
    var collision_shape: CollisionShape2D = area.get_child(0)

    var world_space_state = get_tree().root.get_world_2d().get_direct_space_state()
    var collision_query = PhysicsShapeQueryParameters2D.new()

    collision_query.shape = collision_shape.shape
    collision_query.transform = collision_shape.global_transform
    collision_query.collision_mask = area.collision_mask   

    return world_space_state.intersect_shape(collision_query)


func get_random_color() -> Color:
    return Color(randf(), randf(), randf(), 1.0)
