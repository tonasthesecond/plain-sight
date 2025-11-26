@abstract class_name State
extends Resource

@warning_ignore_start("UNUSED_PARAMETER")
@warning_ignore_start("UNUSED_SIGNAL")

signal entered
signal exited

var target_node: Node
var state_machine: StateMachine
var data: Dictionary

func state_machine_init(
    _state_machine: StateMachine, 
    _target_node: Node, 
    _data: Dictionary
) -> void:
    state_machine = _state_machine
    target_node = _target_node
    data = _data

func enter() -> void: pass
func exit() -> void: pass
func input(event: InputEvent) -> void: pass
func process(delta: float) -> void: pass
func physics_process(delta: float) -> void: pass