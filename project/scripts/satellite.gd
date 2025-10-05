extends Sprite2D
class_name Satellite


@export var central_body : Node2D
@export var orbit_duration := 1.0
@export var current_time := 0.0
@onready var orbit_center : Vector2 = central_body.global_position
@onready var starting_position : Vector2 = global_position


func _process(delta: float) -> void:
	current_time += delta
	GP1_TD.get_satellite_position(orbit_center, orbit_duration, starting_position, current_time)
