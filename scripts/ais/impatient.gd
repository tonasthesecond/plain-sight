extends AIType
# This AI waits for less time before walking

func get_movement_package() -> AIMovementPackage:
    var movement_package = AIMovementPackage.new()
    movement_package.direction = get_random_direction()
    movement_package.walk_time = get_random_from_range(Settings.AI_WALK_TIME_BOUNDS)
    movement_package.wait_time = 0.5 * get_random_from_range(Settings.AI_WAIT_TIME_BOUNDS)

    return movement_package