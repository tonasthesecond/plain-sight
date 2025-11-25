extends Area2D
class_name Weapon


@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
    animation_component.play_animation("attack")
    animation_component.animation_finished.connect(
        func(): 
            
            # Damage closest damageable object
            await get_tree().physics_frame
            var closest_damage_area: Area2D = get_closest_area(get_overlapping_areas())
            if closest_damage_area is DamageAreaComponent:
                closest_damage_area.damaged.emit()

            get_tree().create_tween().tween_property(self, "modulate", Color(1, 1, 1, 0), 0.1).finished.connect(
                func(): queue_free()
            )
    )


func get_closest_area(areas: Array[Area2D]) -> Area2D:
    if areas.size() == 0: return null

    var closest_area: Area2D = areas[0]
    var closest_distance: float = areas[0].global_position.distance_to(global_position)

    for area in areas:
        var distance: float = area.global_position.distance_to(global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_area = area

    return closest_area
