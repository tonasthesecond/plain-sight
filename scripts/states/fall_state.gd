class_name FallState
extends State

func enter() -> void:
    assert("fall_position" in data)
    assert("fall_smoothing_factor" in data)

    data["is_falling"] = true

func process(delta: float) -> void:
    target_node.global_position = Utils.standard_lerp(
        target_node.global_position, 
        data["fall_position"], 
        data["fall_smoothing_factor"],
        delta
    )

    if (data["fall_position"].y - target_node.global_position.y) <= 0.005: # Threshold
        data["is_falling"] = false
