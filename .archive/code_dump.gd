extends Node

    # Get random AI
    # var ai_directory: Array[String]
    # ai_directory.assign(DirAccess.open("res://scripts/ais").get_files())
    # ai_directory = ai_directory.filter(
    #     func(file_name: String) -> bool:
    #         return file_name.ends_with(".gd") and file_name != "ai_type.gd"
    # )
    # var ai_script = load("res://scripts/ais/" + ai_directory[randi() % ai_directory.size()])
    # new_bystander.ai_type = ai_script.new()


    # Bypass buffer if stopping
    # if direction == Vector2.ZERO:
    #     input_frames_timer = input_frames_buffer
    # else:
    #     # Count input frames
    #     if previous_direction != direction:
    #         input_frames_timer = 0
    #         previous_direction = direction
    #     else:
    #         input_frames_timer += 1

    # # Move if input has been held for a certain amount of frames
    # if input_frames_timer >= input_frames_buffer:
    #     if direction != Vector2.ZERO:
    #         previous_direction = direction