extends Node
class_name State

signal Transitioned

var _parameters : CharacterParameters


func init(parameters : Resource):
	_parameters = parameters


func enter():
	#print("super.enter")
	print(self.name + " enter")


func exit():
	#print("super.exit")
	print(self.name + " exit")


func update(delta : float):
	pass


func physics_update(delta : float):
	pass
