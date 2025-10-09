@tool
extends Ship
class_name ExplorerShip


@export var speed := 800.0
@export var path_points : Array[Point] = []

var is_moving := false
var alive := true
var starting_position : Vector2
var final_position : Vector2
var current_time := 0.0
var current_point := 0


func _ready() -> void:
	$SpriteRoot/AnimationShip.play("idle")
	await get_tree().process_frame
	Global.world.move_explorer_ship.connect(start_moving)


func start_moving() -> void:
	set_current_point(0)
	is_moving = true

func set_current_point(new_point : int) -> void:
	current_point = new_point
	current_time = 0.0
	starting_position = global_position
	final_position = path_points[current_point].global_position

func _process(delta: float) -> void:
	if not is_moving:
		return
	current_time += delta
	var new_pos := GP1_TD.lerp_object_position(starting_position, final_position, 
											speed, current_time)
	rotation = GP1_TD.lerp_object_rotation(position, new_pos)
	position = new_pos
	

func _on_ship_hitbox_area_body_entered(body: Node2D) -> void:
	ship_death()

func ship_death() -> void:
	if not alive:
		return
	alive = false
	visible = false
