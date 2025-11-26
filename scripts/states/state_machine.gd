class_name StateMachine
extends Node

var target_node: Node
var states: Array[State]
var state_transitions: Array[StateTransition]
var active_state: State

var data_update_func: Callable
var data: Dictionary

func init(
    _target_node: Node,
    _states: Array[State],
    _data_update_func: Callable,
    _state_transitions: Array[StateTransition],
) -> void:
    target_node = _target_node
    states = _states
    state_transitions = _state_transitions
    data_update_func = _data_update_func
    data = _data_update_func.call()

    for state in states:
        state.state_machine_init(self, target_node, data)

    change_state(states[0])

func process_transitions() -> void:
    data = data_update_func.call()
    for transition in state_transitions:
        if not transition.from_state == active_state: continue
        if not transition.check_data(data): continue

        change_state(transition.to_state)
        transition.triggered.emit()

func change_state(new_state: State) -> void:
    if active_state:
        active_state.exit()
    active_state = new_state
    active_state.enter()

func process(delta: float) -> void:
    active_state.process(delta)
    process_transitions()

func physics_process(delta: float) -> void:
    active_state.physics_process(delta)
    process_transitions()
