extends Sprite2D
class_name Satellite


@export var central_body : Node2D
@export var orbit_duration := 1.0
@export var current_time := 0.0
@export var orbit_radius : Vector2 = Vector2.ZERO
@export var orbit_speed : float = 0.0
@export var starting_angle : float = 0.0

@onready var orbit_center : Vector2 = central_body.global_position
@onready var starting_position : Vector2 = global_position

var has_orbit_started := false


func _ready() -> void:
	Global.world.start_satellite_orbits.connect(start_satellite_orbits)

func start_satellite_orbits() -> void:
	if orbit_radius == Vector2.ZERO or orbit_speed == 0.0:
		var orbit_parameters := GP1_TD.get_satellite_orbit_parameters(
								orbit_center, orbit_duration, starting_position)
		orbit_radius = Vector2.ONE * orbit_parameters["current_angle"]
		orbit_speed = orbit_parameters["speed"]
		starting_angle = orbit_parameters["current_angle"]
	has_orbit_started = true

func _process(delta: float) -> void:
	if not has_orbit_started:
		return
	current_time += delta
	GP1_TD.get_satellite_orbit_position(orbit_center, orbit_radius, orbit_speed, current_time)
	#rotation = starting_angle + delta 
