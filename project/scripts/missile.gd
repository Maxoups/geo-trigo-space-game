extends Sprite2D
class_name Missile


@export var speed := 1000.0
@export var target_position : Vector2
@export var velocity : Vector2
var has_exploded := false


func _process(delta: float) -> void:
	velocity = GP1_TD.get_missile_velocity(position, target_position, speed, delta, velocity)
	position += velocity

func explode() -> void:
	if has_exploded:
		return
	has_exploded = true
	ExplosionEffect.spawn_explosion_effect(global_position)
	queue_free()

func _on_area_collision_body_entered(body: Node2D) -> void:
	if body.has_method("destroy"):
		body.destroy()
	explode()
