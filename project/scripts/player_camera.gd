extends Camera2D
class_name PlayerCamera

@export var camera_speed := 750.0
@export var zoom_speed := 0.03
@export var min_zoom := 0.2
@export var max_zoom := 3.0

func _process(delta: float) -> void:
	var velocity := Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	position += velocity.normalized() * delta * camera_speed

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = (zoom - Vector2.ONE * zoom_speed).clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = (zoom + Vector2.ONE * zoom_speed).clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
