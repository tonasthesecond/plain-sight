extends Node

var queue: Array[String] = []
var priority_queue: Array[String] = []

var is_ready: bool = false

func _ready() -> void:
    await get_tree().process_frame
    Refs.message_bar.message_shown.connect(on_message_shown)
    is_ready = true
    try_show_next()

func queue_message(text: String) -> void:
    queue.push_back(text)
    try_show_next()

func queue_priority_message(text: String) -> void:
    priority_queue.push_back(text)
    try_show_next()

func queue_messages(messages: Array[String]) -> void:
    queue.append_array(messages)
    try_show_next()

func queue_priority_messages(messages: Array[String]) -> void:
    priority_queue.append_array(messages)
    try_show_next()

func try_show_next() -> void:
    if not is_ready: return
    if priority_queue.size() > 0:
        Refs.message_bar.show_message(priority_queue[0], true)
    elif queue.size() > 0:
        Refs.message_bar.show_message(queue[0], false)

func on_message_shown(_text: String, _is_priority: bool) -> void:
    if _is_priority:
        priority_queue.pop_front()
    else:
        queue.pop_front()
    try_show_next()
