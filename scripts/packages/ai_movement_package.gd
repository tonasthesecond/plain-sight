extends Resource
class_name AIMovementPackage

var direction: Vector2 = Vector2.ZERO
var walk_time: float = 0.0
var wait_time: float = 0.0

func _init(
    _direction: Vector2 = Vector2.ZERO,
    _walk_time: float = 0.0,
    _wait_time: float = 0.0
) -> void:
    direction = _direction
    walk_time = _walk_time
    wait_time = _wait_time