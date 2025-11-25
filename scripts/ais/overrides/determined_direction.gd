extends AIType
# This AI will always move in a determined direction

@export var direction: Vector2
@export var walk_time_bounds: Array[float] = Settings.AI_WALK_TIME_BOUNDS
@export var wait_time_bounds: Array[float] = Settings.AI_WAIT_TIME_BOUNDS

func get_movement_package() -> AIMovementPackage:
    var movement_package = AIMovementPackage.new()
    movement_package.direction = direction
    movement_package.walk_time = get_random_from_range(walk_time_bounds)
    movement_package.wait_time = get_random_from_range(wait_time_bounds)

    return movement_package