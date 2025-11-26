extends Node

@export var SPEED: float = Settings.WALK_SPEED

func move(direction: Vector2) -> bool:
    var velocity = direction * SPEED 

    owner.velocity = velocity
    return owner.move_and_slide()
