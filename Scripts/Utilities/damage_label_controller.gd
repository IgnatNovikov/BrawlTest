extends Node3D
class_name DamageLabelController

@export var _dummy : DummyController
@export var _label_timer : Timer

var _last_label : DamageLabel


func _ready():
	_label_timer.timeout.connect(_on_label_timer)
	_dummy.on_take_damage.connect(_take_damage)


func _take_damage(damage : float, damage_point : Vector3):
	if _last_label != null:
		_last_label.queue_free()
	
	_last_label = DamageLabel.new()
	_last_label.text = str(damage)
	#_last_label.global_position = damage_point
	add_child(_last_label)
	_label_timer.start()


func _on_label_timer():
	_last_label.queue_free()
