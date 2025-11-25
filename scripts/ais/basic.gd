class_name BasicAIType
extends AIType
# The standard AI.

func get_movement_package() -> AIMovementPackage:
    return AIMovementPackage.new(
        get_random_direction(),
        get_random_from_range(Settings.AI_WALK_TIME_BOUNDS),
        get_random_from_range(Settings.AI_WAIT_TIME_BOUNDS)
    )
