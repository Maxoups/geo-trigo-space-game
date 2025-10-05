extends Sprite2D
class_name Missile


@export var speed := 1000.0
var has_exploded := false


func _process(delta: float) -> void:
	pass

func get_missile_velocity(position : Vector2, target_position : Vector2, speed : float) -> Vector2:
	return Vector2.ZERO

func explode() -> void:
	if has_exploded:
		return
	has_exploded = true
	

func _on_area_collision_body_entered(body: Node2D) -> void:
	if body.has_method("destroy"):
		body.destroy()
	explode()
