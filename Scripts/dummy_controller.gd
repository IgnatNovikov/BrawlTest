extends CharacterBody3D
class_name DummyController

@export var _view : MeshInstance3D
@export var _health_bar : HealthBarController

@export var _projectile : PackedScene
@export var _shoot_timer : Timer

@export var _push_power : float = 5.0
@export var _stop_power : float = 50.0
@export var _gravity_multiplier : float = 10

@export var _max_health : float
var _current_health : float

@export var _push_timer : Timer

var _direction : Vector3
var _material : StandardMaterial3D
var _default_color : Color

signal on_take_damage


func _ready():
	_push_timer.timeout.connect(_on_push_timer)
	_shoot_timer.timeout.connect(_on_shoot_timer)
	
	_material = _view.mesh.surface_get_material(0)
	_default_color = _material.albedo_color
	
	_current_health = _max_health
	_health_bar.init(_max_health, _max_health)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if _direction:
		#velocity = _direction * _push_velocity
		#velocity.x = _direction.x * _push_velocity
		#velocity.z = _direction.z * _push_velocity
	#else:
	velocity.x = move_toward(velocity.x, 0, _stop_power * delta)
	velocity.y = move_toward(velocity.y, 0, _stop_power * delta)
	velocity.z = move_toward(velocity.z, 0, _stop_power * delta)

	move_and_slide()

func push(direction : Vector3):
	var new_direction := (transform.basis * direction).normalized()
	_direction = new_direction
	velocity = _direction * _push_power
	
	_push_timer.start()

func take_damage(damage : float, damage_point : Vector3):
	on_take_damage.emit(damage, damage_point)
	_material.albedo_color = Color.DARK_RED
	
	if _current_health <= 0:
		_current_health = _max_health
	
	_health_bar.change_bar(_current_health, _current_health - damage, _max_health)
	_current_health -= damage

func _on_push_timer():
	_direction = Vector3.ZERO
	_material.albedo_color = _default_color

func _on_shoot_timer():
	var new_projectile = _projectile.instantiate()
	add_sibling(new_projectile)
