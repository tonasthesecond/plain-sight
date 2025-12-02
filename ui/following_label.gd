extends Label
@export var target_sprite: Sprite2D
@export var follow_x: bool = true
@export var follow_y: bool = false

func _process(_delta: float) -> void:
    if target_sprite:
        # Get center of the sprite image accounting for rotation
        var rotated_offset = target_sprite.offset.rotated(target_sprite.global_rotation)
        var sprite_center = target_sprite.global_position + (rotated_offset * target_sprite.scale)
        
        if follow_x: position.x = sprite_center.x - size.x / 2
        if follow_y: position.y = sprite_center.y - size.y / 2
