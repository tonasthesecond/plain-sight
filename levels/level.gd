class_name Level
extends Node2D

@export var initial_messages: Array[String] = []

func _ready() -> void:
    add_to_group("level")

    MessageSystem.queue_messages(initial_messages)
