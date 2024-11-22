extends State
class_name CharacterKnockBackState

@export var _character : CharacterController

@export var _timer : Timer

func enter():
	print(self.name + " enter")
	_character.velocity.z = _parameters.knock_back_horizontal_velocity
	_character.velocity.y = _parameters.knock_back_vertical_velocity

	_timer.timeout.connect(_on_time_action)
	_timer.start()

#func exit():
	#pass

func physics_update(delta : float):
	_character.velocity.x = move_toward(_character.velocity.x, 0, _parameters.knock_back_slowing_velocity)
	_character.velocity.z = move_toward(_character.velocity.z, 0, _parameters.knock_back_slowing_velocity)
	
	_character.velocity += _character.get_gravity() * _parameters.gravity_multiplier * delta
	
	_character.move_and_slide()

func _on_time_action():
	Transitioned.emit(self, "FallingState")
