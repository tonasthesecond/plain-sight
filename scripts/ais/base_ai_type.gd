class_name BaseAIType
extends AIType
# The standard AI.

func get_movement_package() -> AIMovementPackage:
    return AIMovementPackage.new(
        Utils.get_random_integer_direction(),
        Utils.get_random_float_from_range(Settings.AI_WALK_TIME_BOUNDS),
        Utils.get_random_float_from_range(Settings.AI_WAIT_TIME_BOUNDS)
    )
