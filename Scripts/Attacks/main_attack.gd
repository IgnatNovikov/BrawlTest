extends Area3D
class_name MainAttack

@export var _collider : CollisionShape3D
@export var _timer : Timer
@export var _particles : GPUParticles3D

var _damage : float

var _callback : Callable

var _attack_direction : Vector3

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_timer.timeout.connect(_on_timer)

func _on_body_entered(node : Node):
	if node is DummyController:
		#var direction = transform.basis * Vector3.FORWARD
		#direction = to_global(direction)
		node.push(_attack_direction)
		var damage_point = (global_position - node.global_position) / 2
		#var damage_point = transform.looking_at(node.global_position)
		node.take_damage(_damage, damage_point)

func attack(damage : float, direction : Vector3):
	if not _timer.is_stopped():
		return
	
	_damage = damage
	_attack_direction = direction
	
	_collider.disabled = false
	_collider.visible = true
	_particles.emitting = true
	
	_timer.start()

func set_callback(callback : Callable):
	_callback = callback

func _on_timer():
	_collider.disabled = true
	_collider.visible = false
	_particles.emitting = false
	_particles.restart()
	_callback.call()
