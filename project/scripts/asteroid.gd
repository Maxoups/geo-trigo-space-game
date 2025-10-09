extends Sprite2D
class_name Asteroid


const ASTEROID_RADIUS := [240.0, 175.0, 125.0, 70.0]

@export var polygon_appear_delay := 0.0
@export var is_regular := true

@onready var anim_time := randf_range(0.9, 1.4)
@onready var rotation_start := rotation + randf_range(PI/15, PI/10)
@onready var rotation_end := rotation
@onready var polygons : Array[Polygon2D] = [$Polygon2D, $PolygonInner1, $PolygonInner2]

var idle_anim_tween : Tween = null


func _ready() -> void:
	idle_animation()
	await get_tree().process_frame
	Global.world.generate_asteroids.connect(generate_asteroid_polygon)

func explode(impact_point : Vector2, explosion_force : float) -> void:
	if len($Polygon2D.polygon) == 0:
		print_debug("Polygon has not been drawn ; can't explode asteroid!")
		return
	visible = false
	if is_instance_valid(idle_anim_tween):
		idle_anim_tween.kill()
	$StaticBody2D.queue_free()
	var fragments := GP1_TD.shatter_polygon($Polygon2D.polygon, randi_range(8, 14))
	for fragment : PackedVector2Array in fragments:
		AsteroidFragment.spawn_asteroid_fragment(
			global_position, 
			global_rotation, 
			fragment, 
			GP1_TD.explode_fragment($Polygon2D.polygon, global_position, fragment, 
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
	idle_anim_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	idle_anim_tween.tween_property(self, "rotation", rotation_start, anim_time)
	idle_anim_tween.tween_property(self, "rotation", rotation_end, anim_time)
	idle_anim_tween.finished.connect(idle_animation)
