extends BasicAIType
# This AI moves at a higher speed

func get_movement_package() -> AIMovementPackage:
    var movement_package = super()
    movement_package.direction = 1.2 * get_random_direction()
    return movement_package