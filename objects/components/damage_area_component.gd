extends Area2D
class_name DamageAreaComponent

signal damaged

func _on_body_entered(_body: Node2D) -> void:
    damaged.emit()
