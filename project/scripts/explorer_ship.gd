@tool
extends Ship
class_name ExplorerShip


var alive := true


func _ready() -> void:
	$SpriteRoot/AnimationShip.play("idle")

func _on_ship_hitbox_area_body_entered(body: Node2D) -> void:
	ship_death()

func ship_death() -> void:
	if not alive:
		return
	alive = false
	visible = false
