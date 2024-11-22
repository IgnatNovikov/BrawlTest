extends MeshInstance3D
class_name HealthBarController

@export var _length : float = .3
@export var _delay : float = .2

func init(value : float, max : float):
	set_instance_shader_parameter("Progress", value / max)
	set_instance_shader_parameter("DelayedProgress", value / max)

func change_bar(from : float, to : float, max : float):
	var tween : Tween = create_tween()
	set_instance_shader_parameter("Progress", to / max)
	tween.tween_method(_progress, from / max, to / max, _length).set_delay(_delay)

func _progress(value : float):
	set_instance_shader_parameter("DelayedProgress", value)
