class_name MessageBar
extends Node

@onready var label: Label = $Label
@onready var idle_timer: Timer = $IdleTimer

const OPACITY_CHANGE_RATE: float = 1 # Opacity change per second
const IDLE_TIME: float = 3

@export var queue: Array[String] = []
@export var priority_queue: Array[String] = []

var opacity_tween: Tween

func _process(_delta: float) -> void:
    # Only change text after idling
    if not idle_timer.is_stopped(): return
    if opacity_tween and opacity_tween.is_running(): return
    
    if priority_queue.size() > 0:
        show_message(priority_queue.pop_front())
    elif queue.size() > 0:
        show_message(queue.pop_front())

func queue_message(message: String) -> void:
    queue.push_back(message)

func queue_priority_message(message: String) -> void:
    priority_queue.push_back(message)

func show_message(message: String, priority: bool = false) -> void:
    # Hide current text
    if label.modulate.a > 0:
        opacity_tween = create_tween()
        opacity_tween.tween_property(
            label, "modulate:a", 
            0, 
            abs(0 - label.modulate.a) / OPACITY_CHANGE_RATE
            )
        await opacity_tween.finished

    # Change and show new text
    label.text = message

    if priority:
        label.modulate = Color.RED
    else:
        label.modulate = Color.WHITE
    label.modulate.a = 0

    opacity_tween = create_tween()
    opacity_tween.tween_property(
        label, "modulate:a", 
        1, 
        abs(1 - label.modulate.a) / OPACITY_CHANGE_RATE
        )

    await opacity_tween.finished

    # Start idle time
    idle_timer.start(IDLE_TIME)
