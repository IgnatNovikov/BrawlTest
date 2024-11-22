extends Label3D
class_name DamageLabel

var _destination_point : Vector3

const _move_speed : float = 25

func _ready():
	rotation.x = deg_to_rad(-60)
	font_size = 64
	uppercase = true
	pixel_size = 0.005
	
	_destination_point = position + Vector3.UP * 1.5

func _physics_process(delta: float):
	var move_direction = position
	move_direction.y = move_toward(position.y, _destination_point.y, _move_speed * delta)
	position = move_direction
