extends Sprite2D
class_name Asteroid


const ASTEROID_RADIUS := [240.0, 175.0, 125.0, 70.0]

@export var polygon_appear_delay := 0.0
@export var is_regular := true

@onready var anim_time := randf_range(0.9, 1.4)
@onready var rotation_start := rotation + randf_range(PI/15, PI/10)
@onready var rotation_end := rotation
@onready var polygons : Array[Polygon2D] = [$Polygon2D, $PolygonInner1, $PolygonInner2]


func _ready() -> void:
	idle_animation()
	await get_tree().process_frame
	Global.world.generate_asteroids.connect(generate_asteroid_polygon)

func explode(impact_point : Vector2, explosion_force : float) -> void:
	if len($Polygon2D.polygon) == 0:
		print_debug("Polygon has not been drawn ; can't explode asteroid!")
		return
	visible = false
	$StaticBody2D.queue_free()
	var polygons := GP1_TD.shatter_polygon($Polygon2D.polygon, randi_range(8, 14))
	for polygon : PackedVector2Array in polygons:
		var p_center := Vector2.ZERO
		for p : Vector2 in polygon:
			p_center += p
		p_center /= float(polygon.size())
		AsteroidFragment.spawn_asteroid_fragment(
			global_position + p_center, 
			0.0, polygon, GP1_TD.explode_fragment($Polygon2D.polygon, polygon, 
													impact_point, explosion_force)
		)

func generate_asteroid_polygon() -> void:
	await get_tree().create_timer(polygon_appear_delay).timeout
	if is_regular:
		_draw_all_regular_polygons()
	else:
		_draw_all_random_polygons()
	if len($Polygon2D.polygon) > 0:
		self_modulate = Color.TRANSPARENT
		$Line2D.points = $Polygon2D.polygon
		for p : Polygon2D in polygons:
			p.global_scale = Vector2.ONE
		$Line2D.global_scale = Vector2.ONE

func _draw_all_regular_polygons() -> void:
	for i : int in range(len(polygons)):
		var p := polygons[i]
		p.polygon = GP1_TD.generate_regular_polygon(
							scale.x * ASTEROID_RADIUS[i], 
							randi_range(6, 12))

func _draw_all_random_polygons() -> void:
	for i : int in range(len(polygons)):
		var p := polygons[i]
		p.polygon = GP1_TD.generate_random_polygon(
							scale.x * ASTEROID_RADIUS[i], 
							scale.x * ASTEROID_RADIUS[i+1], 
							randi_range(6, 12))

func idle_animation() -> void:
	var new_rot := rotation + randf_range(-PI/2, PI/2)
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "rotation", rotation_start, anim_time)
	t.tween_property(self, "rotation", rotation_end, anim_time)
	t.finished.connect(idle_animation)
