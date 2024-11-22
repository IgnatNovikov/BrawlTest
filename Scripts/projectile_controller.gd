extends RigidBody3D
class_name ProjectileController

@export var _speed : float = 5.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_collide(-transform.basis.z * delta * _speed)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("stagger"):
		body.stagger()
