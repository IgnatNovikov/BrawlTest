extends State
class_name CharacterFallingState

@export var _character : CharacterController
@export var _view : MeshInstance3D


#func enter():
	#pass


#func exit():
	#pass


func update(delta : float):
	if Input.is_action_just_pressed("MainAttack"):
		Transitioned.emit(self, "MainAttack1State")
	
	if Input.is_action_just_pressed("Jump") and _character.can_jump:
			Transitioned.emit(self, "JumpState")


func physics_update(delta : float):
	if not _character.is_on_floor():
		_character.velocity += _character.get_gravity() * _parameters.gravity_multiplier * delta
	else:
		_character.can_jump = true
		if _character.is_on_floor():
			Transitioned.emit(self, "MovingState")
		if Input.is_action_just_pressed("Jump") and _character.can_jump:
			Transitioned.emit(self, "JumpState")
	
	var input_dir : Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	if _character.is_on_floor():
		Transitioned.emit(self, "IdleState")
	_set_view(input_dir)
	var direction : Vector3 = (_character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		_character.velocity.x = direction.x * _parameters.move_speed
		_character.velocity.z = direction.z * _parameters.move_speed
	else:
		_character.velocity.x = move_toward(_character.velocity.x, 0, _parameters.slow_velocity)
		_character.velocity.z = move_toward(_character.velocity.z, 0, _parameters.slow_velocity)

	_character.move_and_slide()


func _set_view(input : Vector2):
	if input != Vector2.ZERO:
		var direction : Vector3 = Vector3(input.x, _view.position.y, input.y)
		_view.transform = _view.transform.looking_at(direction)
