class_name HoverState
extends State

func enter() -> void:
    assert(data["float_target"] is PhysicsBody2D)
    assert("y_oscillation_amplitude" in data)
    assert("y_oscillation_rate" in data)
    assert("follow_smoothing_factor" in data)
    assert("float_height" in data)

    data["collision_data"] = Utils.disable_collisions(target_node)
    data["relative_position"] = target_node.global_position - data["float_target"].global_position

func exit() -> void:
    Utils.enable_collisions(target_node, data["collision_data"])
    data["float_target"] = null
    data["fall_position"] = data["hover_position"] + Vector2(0, data["float_height"])

func physics_process(delta: float) -> void:
    data["hover_position"] = data["float_target"].global_position + Vector2(0, -data["float_height"]) + data["relative_position"]
    data["hover_position"].y += sin(Time.get_ticks_msec() / 1000.0 * data["y_oscillation_rate"]) * data["y_oscillation_amplitude"]
    target_node.global_position = Utils.standard_lerp(
        target_node.global_position, 
        data["hover_position"], 
        data["follow_smoothing_factor"],
        delta
    )
