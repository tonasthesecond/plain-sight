extends Node

func get_colliders_from_object(object: CollisionObject2D) -> Array[Dictionary]:
    var collision_shape: CollisionShape2D = object.get_child(0)

    var world_space_state = get_tree().root.get_world_2d().get_direct_space_state()
    var collision_query = PhysicsShapeQueryParameters2D.new()

    collision_query.shape = collision_shape.shape
    collision_query.transform = collision_shape.global_transform
    collision_query.collision_mask = object.collision_mask   

    return world_space_state.intersect_shape(collision_query)

func get_random_color() -> Color:
    return Color(randf(), randf(), randf(), 1.0)

func select_random_item(items: Array, weights: Array = []) -> Variant:
    if weights.size() == 0:
        return items[randi() % items.size()]

    var total = 0
    for w in weights:
        total += w
    
    var r = randf() * total
    var cumsum = 0
    
    for i in range(items.size()):
        cumsum += weights[i]
        if r <= cumsum:
            return items[i]
    
    return items[-1]  # fallback

func get_random_float_from_range(range_bounds: Vector2) -> float:
    return randf_range(range_bounds.x, range_bounds.y)

func get_random_integer_direction() -> Vector2:
    var random_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
    while random_direction.length() == 0:
        random_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
    return random_direction

func standard_lerp(start: Variant, end: Variant, smoothing: float, delta: float) -> Variant:
    return lerp(start, end, 1 - exp(-smoothing * delta)) # This is framerate independent

func get_random_predefined_color() -> Color:
    return select_random_item(Settings.PREDEFINED_COLORS)

func vector_direction_to_string(vector: Vector2) -> String:
    if vector.x > 0:
        return "right"
    elif vector.x < 0:
        return "left"
    elif vector.y > 0:
        return "down"
    elif vector.y < 0:
        return "up"
    else:
        return ''
