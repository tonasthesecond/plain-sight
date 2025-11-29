extends Node

# Colors
const PREDEFINED_COLORS: Array[Color] = [
    Color.LIGHT_CORAL, Color.CYAN, Color.LIME, Color.YELLOW,
    Color.WHITE
]
const ACCENT_COLOR: Color = Color.LIGHT_CORAL

# Base stats
const WALK_SPEED: float = 30.0
const AI_WALK_TIME_BOUNDS := Vector2(1.0, 2.0)
const AI_WAIT_TIME_BOUNDS := Vector2(4.0, 6.0)

# Information
var PLAYER_NAMES: Array[String] = ["Player 1", "Player 2"]
var PLAYER_STRING_IDS: Array[String] = ["player1", "player2"]

# Alterable stats
var PLAYER_WALK_SPEED_MULT: Array[float] = [1.0, 1.0]
var WEAPON_DRAW_SPEED_MULT: Array[float] = [1.0, 1.0]
