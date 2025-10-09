extends Polygon2D
class_name AsteroidFragment


const FRAGMENT_RES := preload("res://scenes/space_objects/asteroid_fragment.tscn")


static func spawn_asteroid_fragment(pos : Vector2, rot : float, polygon : PackedVector2Array, 
									velocity : Vector2) -> void:
	var fragment := FRAGMENT_RES.instantiate()
	fragment.global_position = pos
	fragment.global_rotation = rot
	fragment.polygon = polygon
	fragment.velocity = velocity
	Global.world.add_child(fragment)


var velocity : Vector2
var debug_mult := 0.0


func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	debug_mult = 1.0

func _process(delta: float) -> void:
	position += velocity * delta * debug_mult
