extends Node
class_name CharacterStateMachine

@export var _parameters : CharacterParameters
@export var _initial_state : State

var _states : Dictionary = {}
var _current_state : State

func _ready():
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.Transitioned.connect(_on_child_transition)
			child.init(_parameters)
	if _initial_state:
		_initial_state.enter()
		_current_state = _initial_state

func _process(delta: float):
	if _current_state:
		_current_state.update(delta)

func _physics_process(delta: float):
	if _current_state:
		_current_state.physics_update(delta)

func _on_child_transition(state : State, new_state_name : String):
	if state != _current_state:
		return
	
	var new_state : State = _states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if _current_state:
		_current_state.exit()
	
	_current_state = new_state
	
	_current_state.enter()
