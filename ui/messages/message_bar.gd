class_name MessageBar
extends Control

signal message_shown(text: String, is_priority: bool)

@onready var label: Label = $Label
@onready var idle_timer: Timer = $IdleTimer

const IDLE_TIME: float = 3

func _ready() -> void:
    modulate.a = 0

func show_message(text: String, is_priority: bool):
    if not idle_timer.is_stopped(): return 
    
    # Fade out current
    await Utils.fade_node(self, 0).finished
    
    # Show new text
    modulate = Settings.ACCENT_COLOR if is_priority else Color.WHITE
    modulate.a = 0
    label.text = text

    var fade_in_rate = 1 if is_priority else 3
    await Utils.fade_node(self, 1, fade_in_rate).finished
    
    idle_timer.start(IDLE_TIME)
    await idle_timer.timeout
    Utils.fade_node(self, 0)
    message_shown.emit(text, is_priority)
