@tool
extends Node2D
class_name Ship


@export var ship_name := "S":
	set(value):
		ship_name = value
		update_label_text()
var current_transform : Transform2D



func _process(_delta: float) -> void:
	if current_transform != $Sprite.global_transform:
		current_transform = $Sprite.global_transform
		update_label_text()

func update_label_text() -> void:
	var pos_x := position.x/100
	var pos_y := position.y/100
	var r : float = $Sprite.global_rotation_degrees
	$Label.text = ship_name + " (x=%0.2f, y=%0.2f, r=%0.2f)" % [pos_x, pos_y, r]
