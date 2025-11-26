extends Resource
class_name AIMovementPackage

var direction: Vector2 = Vector2.ZERO
var move_time: float = 0.0
var idle_time: float = 0.0

func _init(
    _direction: Vector2 = direction,
    _move_time: float = move_time,
    _idle_time: float = idle_time
) -> void:
    direction = _direction
    move_time = _move_time
    idle_time = _idle_time