@tool
extends Ship
class_name MotherShip


@onready var cannon_hull := $SpriteRoot/ShipSprites/ShipHull/ShipCannonHull
@onready var cannon_cockpit := $SpriteRoot/ShipSprites/ShipHull/ShipHead/ShipCannonCockpit


func _ready() -> void:
	$SpriteRoot/ShipSprites/AnimationShip.play("ship_idle")

func play_hull_cannon_idle() -> void:
	var new_cannon_rotation := randf_range(-0.75*PI, 0.75*PI)
	var movement_duration := randf_range(0.3, 0.7)
	var animation_delay := movement_duration + randf_range(0.5, 3.0)
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(cannon_hull, "rotation", new_cannon_rotation, movement_duration)
	$SpriteRoot/ShipSprites/HullCannonAnimTimer.start(animation_delay)
