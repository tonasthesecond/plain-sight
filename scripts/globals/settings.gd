extends Node

const WALK_SPEED: float = 30.0
const AI_WALK_TIME_BOUNDS := Vector2(1.0, 2.0)
const AI_WAIT_TIME_BOUNDS := Vector2(4.0, 6.0)

const PREDEFINED_COLORS: Array[Color] = [
    Color.LIGHT_CORAL, Color.CYAN, Color.LIME, Color.YELLOW,
    Color.WHITE
]

var PLAYER_WALK_SPEED: Array[float] = [WALK_SPEED, WALK_SPEED]
var WEAPON_DRAW_SPEED: Array[float] = [1.0, 1.0]