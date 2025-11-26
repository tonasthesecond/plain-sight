class_name StateTransition
extends Resource

@warning_ignore_start("UNUSED_SIGNAL")
signal triggered

var from_state: State
var to_state: State
var data_checks: Array

func _init(_from_state: State, _to_state: State, _data_checks: Array = []) -> void:
    from_state = _from_state
    to_state = _to_state
    data_checks = _data_checks

func check_data(data: Dictionary) -> bool:
    for check: String in data_checks:
        assert(check in data or check.substr(1) in data)
        if check[0] != "!" and not data[check]:
            return false
        elif check[0] == "!" and data[check.substr(1)]:
            return false
    return true
