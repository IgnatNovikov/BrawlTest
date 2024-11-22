extends State
class_name CharacterJumpState

@export var _character : CharacterController
@export var _jump_particles : PackedScene

func enter():
	print(self.name + " enter")
	_character.can_jump = false
	_character.velocity.y = _parameters.jump_velocity
	var particles = _jump_particles.instantiate()
	add_sibling(particles)
	var particle_position = _character.global_position
	particle_position.y -= 1
	particles.global_position = particle_position
	(particles as GPUParticles3D).emitting = true

#func exit():
	#pass

#func update(delta : float):
	#pass

func physics_update(delta : float):
	Transitioned.emit(self, "FallingState")
