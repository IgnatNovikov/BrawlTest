extends State
class_name CharacterStaggerState

@export var _character : CharacterController
@export var _timer : Timer


func enter():
	print(self.name + " enter")
	
	_timer.timeout.connect(_on_timer)
	_timer.start()


#func exit():
	#pass


#func update(delta : float):
	#pass


#func physics_update(delta : float):
	#pass


func _on_timer():
	Transitioned.emit(self, "Idle")
