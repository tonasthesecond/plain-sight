class_name DamageAreaComponent
extends StaticBody2D

signal damaged(damager: Node)

func damage(damager: Node) -> void:
    damaged.emit(damager)
