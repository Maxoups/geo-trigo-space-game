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


func _process(delta: float) -> void:
	position += velocity * delta
