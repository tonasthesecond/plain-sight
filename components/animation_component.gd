class_name AnimationComponent
extends AnimationPlayer

func play_animation(animation_name: String) -> void:
    play(get_animation_in_libraries(animation_name))

func play_directional_animation(animation_name: String, movement_provider: MovementProvider) -> void:
    var direction: Vector2 = movement_provider.get_animation_direction()
    var full_animation_name: String = animation_name + "_" + Utils.vector_direction_to_string(direction)
    play(get_animation_in_libraries(full_animation_name))

func stop_animation() -> void:
    stop()

func get_animation_in_libraries(animation_name: String) -> String:
    for animation_library_name in get_animation_library_list():
        var animation_library: AnimationLibrary = get_animation_library(animation_library_name)
        if animation_library.has_animation(animation_name):
            return animation_library_name + "/" + animation_name
    return get_animation_library_list()[0] + "/RESET"
