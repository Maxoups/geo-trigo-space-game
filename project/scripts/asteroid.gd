extends Sprite2D
class_name Asteroid


@onready var anim_time := randf_range(0.9, 1.4)
@onready var rotation_start := rotation - randf_range(-PI/2, PI/2)
@onready var rotation_end := rotation_start + randf_range(PI/6, PI/2)


func _ready() -> void:
	idle_animation()

func idle_animation() -> void:
	var new_rot := rotation + randf_range(-PI/2, PI/2)
	var t := create_tween().set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "rotation", rotation_start, anim_time)
	t.tween_property(self, "rotation", rotation_end, anim_time)
	t.finished.connect(idle_animation)
