extends MeshInstance3D
class_name RadialProgressController

@export var _timer : Timer


func _ready():
	_timer.timeout.connect(_on_timer)

func _process(delta: float) -> void:
	if not _timer.is_stopped():
		set_instance_shader_parameter("Progress", (_timer.wait_time - _timer.time_left) / _timer.wait_time)

func _on_timer():
	set_instance_shader_parameter("Progress", 1.0)
