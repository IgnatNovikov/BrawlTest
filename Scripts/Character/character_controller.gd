extends CharacterBody3D
class_name CharacterController

const ray_length = 1000

@export var _stagger_time : float
@export var _max_health : float
@export var _damage : float
@export var _health_bar : HealthBarController
var _current_health : float

@onready var _camera : Camera3D = $Camera3D

var can_jump : bool


func _ready():
	can_jump = true
	
	_current_health = _max_health
	
	_health_bar.init(_max_health, _max_health)

func _physics_process(delta: float) -> void:
	pass

#func _input(event):
	#var mouse_pos = get_viewport().get_mouse_position()
	#var from = _camera.project_ray_origin(mouse_pos)
	#var to = from + _camera.project_ray_normal(mouse_pos) * ray_length
	#
	#var space_state = get_world_3d().direct_space_state
	#var params = PhysicsRayQueryParameters3D.new()
	#params.from = from
	#params.to = to
	#params.collide_with_areas = false  # Set to true to include Area nodes
	#params.collide_with_bodies = true  # Set to true to include PhysicsBody nodes (don't know if necessary)
#
	#var result = space_state.intersect_ray(params)
	#if result:
		#if result.collider and result.collider.is_class("Area3D"):
			#result.collider.on_ray_hit()
			#print(result.position)
		#else:
			##print("Raycast hit:", result.collider.name)
			#print(result.position)

func stagger():
	if _current_health <= 0:
		_current_health = _max_health
	
	_health_bar.change_bar(_current_health, _current_health - _damage, _max_health)
	
	_current_health -= _damage
	print("STAGGER")
