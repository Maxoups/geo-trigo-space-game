extends Node2D
class_name World


func _ready() -> void:
	$Grid/AnimationPlayer.play("grid_idle")
