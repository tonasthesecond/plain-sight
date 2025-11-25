extends Resource
class_name AIType

func get_movement_package() -> AIMovementPackage:
    return null

func get_random_direction() -> Vector2:
    var random_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
    while random_direction.length() == 0:
        random_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
    return random_direction

func get_random_from_range(range_bounds: Array[float]) -> float:
    return randf_range(range_bounds[0], range_bounds[1])