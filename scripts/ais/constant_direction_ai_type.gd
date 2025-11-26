extends AIType
# This AI will always move in a determined direction

@export var direction: Vector2
@export var walk_time_bounds: Vector2 = Settings.AI_WALK_TIME_BOUNDS
@export var wait_time_bounds: Vector2 = Settings.AI_WAIT_TIME_BOUNDS

func get_movement_package() -> AIMovementPackage:
    return AIMovementPackage.new(
        direction,
        Utils.get_random_float_from_range(walk_time_bounds),
        Utils.get_random_float_from_range(wait_time_bounds)
    )