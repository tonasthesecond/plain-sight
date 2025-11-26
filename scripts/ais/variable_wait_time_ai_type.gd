class_name VariableWaitTimeAIType
extends AIType
## AIType with variable wait time.

@export var time_multiplier: Vector2 = Vector2(1.0, 1.0)

func _init(_time_multiplier: Vector2 = time_multiplier) -> void:
    time_multiplier = _time_multiplier

func get_movement_package() -> AIMovementPackage:
    return AIMovementPackage.new(
        Utils.get_random_integer_direction(),
        Utils.get_random_float_from_range(Settings.AI_WALK_TIME_BOUNDS),
        Utils.get_random_float_from_range(time_multiplier * Settings.AI_WAIT_TIME_BOUNDS)
    )