class_name Weapon
extends Area2D

@onready var animation_component: AnimationComponent = $AnimationComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
    animation_component.play_animation("attack")
    animation_component.animation_finished.connect(
        func(): 
            # Damage closest damageable object
            await get_tree().physics_frame
            
            var closest_damage_area: DamageAreaComponent = get_closest_damage_component(get_overlapping_bodies())
            if closest_damage_area is DamageAreaComponent:
                closest_damage_area.damage(get_parent())

            get_tree().create_tween().tween_property(
                self, 
                "modulate", 
                Color(1, 1, 1, 0), 
                0.2
                ).finished.connect(queue_free)
    )

func get_closest_damage_component(bodies: Array[Node2D]) -> DamageAreaComponent:
    if bodies.size() == 0: return null

    var closest_body: Node2D = bodies[0]
    var closest_distance: float = bodies[0].global_position.distance_to(global_position)

    for body in bodies:
        var distance: float = body.global_position.distance_to(global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_body = body

    return closest_body
