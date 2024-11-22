extends Resource
class_name CharacterParameters

@export_group("Move parameters")
@export var move_speed : float
@export var gravity_multiplier : float
@export var jump_velocity : float
@export var slow_velocity : float

@export_group("Knock back parameters")
@export var knock_back_horizontal_velocity : float
@export var knock_back_vertical_velocity : float
@export var knock_back_slowing_velocity : float

@export_group("Stagger parameters")
@export var stagger_velocity : float
