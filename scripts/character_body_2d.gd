extends CharacterBody2D
@export var ray_cast_left: RayCast2D
@export var ray_cast_down: RayCast2D
@export var ray_cast_up: RayCast2D
@export var ray_cast_right: RayCast2D
@export var collision_shape_2d: CollisionShape2D
var stick = false

const SPEED = 100
func _ready() -> void:
	velocity = Vector2(randf_range(-SPEED,SPEED),randf_range(-SPEED,SPEED))
	
	
func _process(delta: float) -> void:
	if stick == true:
		position = get_global_mouse_position()
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and mouse_entered and stick == false:
			stick = true
		else: if event.button_index == MOUSE_BUTTON_RIGHT and stick == true:
			stick = false

func _physics_process(delta: float) -> void:
	if ray_cast_down.is_colliding():
		velocity.y += -SPEED
	if ray_cast_right.is_colliding():
		velocity.x += -SPEED
	if ray_cast_up.is_colliding():
		velocity.y += SPEED
	if ray_cast_left.is_colliding():
		velocity.x += SPEED
	
	
	move_and_slide()
