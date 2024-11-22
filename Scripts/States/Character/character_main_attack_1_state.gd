extends State
class_name CharacterMainAttack1State

@export var _character : CharacterController
@export var _character_view : MeshInstance3D
@export var _main_attack : MainAttack

@export var _damage : float
@export var _power : float
@export var _slowing : float

@export var _camera : Camera3D
@export_flags_3d_physics var _mask : int
const ray_length = 1000

@export var _timer : Timer

var _can_attack : bool

func _ready():
	_can_attack = true
	_timer.timeout.connect(_on_timer_end)

func enter():
	print(self.name + " enter")
	
	if not _can_attack:
		Transitioned.emit(self, "IdleState")
		return
	
	if _can_attack:
		_can_attack = false
		_timer.start()
		
		var direction = _character_view.transform.basis * Vector3.FORWARD - _character_view.position
		direction.y = 0.0
		_character.velocity = direction * _power
		
		_main_attack.attack(_damage, direction)
		_main_attack.set_callback(_on_attack_end)
		
		_rotate_to_mouse()

#func exit():
	#pass

#func update(delta : float):
	#pass

func physics_update(delta : float):
	_character.velocity.x = move_toward(_character.velocity.x, 0, _slowing)
	_character.velocity.z = move_toward(_character.velocity.z, 0, _slowing)
	
	_character.move_and_slide()

func _rotate_to_mouse():
	var mouse_pos = get_viewport().get_mouse_position()
	var from = _camera.project_ray_origin(mouse_pos)
	var to = from + _camera.project_ray_normal(mouse_pos) * ray_length
	
	var space_state = _character.get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	params.collide_with_areas = false  # Set to true to include Area nodes
	params.collide_with_bodies = true  # Set to true to include PhysicsBody nodes (don't know if necessary)
	params.collision_mask = _mask

	var result = space_state.intersect_ray(params)
	if result:
		if result.collider:
			_character_view.look_at(result.position)

func _on_attack_end():
	Transitioned.emit(self, "IdleState")

func _on_timer_end():
	_can_attack = true
