@tool
extends Ship
class_name ExplorerShip


func _ready() -> void:
	$SpriteRoot/AnimationShip.play("idle")
