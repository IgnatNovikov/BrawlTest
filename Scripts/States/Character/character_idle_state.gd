extends State
class_name CharacterIdleState

@export var _character : CharacterController


#func enter():
	#pass


#func exit():
	#pass


#func update(delta : float):
	#pass


func physics_update(delta : float):
	if !_character.is_on_floor():
		Transitioned.emit(self, "FallingState")
	
	var input : Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	if input != Vector2.ZERO:
		Transitioned.emit(self, "MovingState")
		return
	
	if Input.is_action_just_pressed("Jump"):
		Transitioned.emit(self, "JumpState")
		return
	
	if Input.is_action_just_pressed("ui_text_indent"):
		Transitioned.emit(self, "StaggerState")
		return
	
	if Input.is_action_just_pressed("MainAttack"):
		Transitioned.emit(self, "MainAttack1State")
		return
