class_name AnimatedState
extends State

var wrapped_state: State
var animation_component: AnimationComponent
var movement_provider: MovementProvider

var process_animation_name: String = ""
var enter_animation_name: String = ""
var exit_animation_name: String = ""

func _init(
    _wrapped_state: State,
    _enter_animation_name: String = enter_animation_name,
    _process_animation_name: String = process_animation_name,
    _exit_animation_name: String = exit_animation_name,
    _animation_player: AnimationComponent = null,
    _directional_movement_provider: MovementProvider = null,
) -> void:
    wrapped_state = _wrapped_state
    animation_component = _animation_player
    process_animation_name = _process_animation_name
    enter_animation_name = _enter_animation_name
    exit_animation_name = _exit_animation_name
    movement_provider = _directional_movement_provider

func state_machine_init(
    _state_machine: StateMachine, 
    _target_node: Node, 
    _data: Dictionary
) -> void:
    super(_state_machine, _target_node, _data)
    wrapped_state.state_machine_init(_state_machine, _target_node, _data)

func enter() -> void:
    if enter_animation_name:
        play_animation(enter_animation_name)
    wrapped_state.enter()

func exit() -> void:
    if exit_animation_name:
        play_animation(exit_animation_name)
    wrapped_state.exit()

func process(delta: float) -> void:
    if process_animation_name:
        play_animation(process_animation_name)
    wrapped_state.process(delta)

func physics_process(delta: float) -> void:
    if process_animation_name:
        play_animation(process_animation_name)
    wrapped_state.physics_process(delta)

func play_animation(animation_name: String) -> void:
    if movement_provider:
        animation_component.play_directional_animation(animation_name, movement_provider)
    else:
        animation_component.play_animation(animation_name)
