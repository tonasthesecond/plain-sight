extends AIType
# This AI have constant, rapid movement


func get_movement_package() -> AIMovementPackage:
    var movement_package = AIMovementPackage.new()
    movement_package.direction = get_random_direction()
    movement_package.walk_time = get_random_from_range([Settings.AI_WALK_TIME_BOUNDS[0], 1.3 * Settings.AI_WALK_TIME_BOUNDS[0]])
    movement_package.wait_time = 0.7 * get_random_from_range(Settings.AI_WAIT_TIME_BOUNDS)

    return movement_package

