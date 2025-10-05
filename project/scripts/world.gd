extends Node2D
class_name World


func _ready() -> void:
	Global.world = self
	$Grid/AnimationPlayer.play("grid_idle")
