extends Camera2D

var drag: bool = false

@export var zoom_speed: float = 0.1
@export var min_zoom: Vector2 = Vector2(0.2, 0.2)
@export var max_zoom: Vector2 = Vector2(3.0, 3.0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_camera(-zoom_speed)
			
		if event.button_index == MOUSE_BUTTON_LEFT:
			drag = event.pressed

	if event is InputEventMouseMotion and drag:
		position.x -= event.relative.x / zoom.x
		position.y -= event.relative.y / zoom.y

func zoom_camera(amount: float) -> void:
	var target_zoom = zoom + Vector2(amount, amount)
	zoom = target_zoom.clamp(min_zoom, max_zoom)
