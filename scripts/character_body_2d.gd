extends CharacterBody2D
@export var ray_cast_left: RayCast2D
@export var ray_cast_down: RayCast2D
@export var ray_cast_up: RayCast2D
@export var ray_cast_right: RayCast2D
@export var collision_shape_2d: CollisionShape2D
@export var area_2d: Area2D
@export var goob_sprite: AnimatedSprite2D

var stick = false
var drag
var mine = false
var run = false
var color = randi_range(1,6)
var shirt = "Blue"
@export var limit_min: Vector2 = Vector2(-2000, -2000)
@export var limit_max: Vector2 = Vector2(2000, 2000)
@onready var parent = get_parent() as PathFollow2D
var SPEED = randf_range(50,150)
func _ready() -> void:
	if color == 1:
		shirt = "Blue"
	elif color == 2:
		shirt = "Orange"
	elif color == 3:
		shirt = "P"
	elif color == 4:
		shirt = "Pink"
	elif color == 5:
		shirt = "Purple"
	elif color == 6:
		shirt = "Yellow"
	goob_sprite.animation = "Idle" + shirt
	velocity = Vector2(randf_range(-SPEED,SPEED),randf_range(-SPEED,SPEED))
	
func _process(delta: float) -> void:
	if drag == true:
		position = get_global_mouse_position().clamp(limit_min, limit_max)
		velocity = Input.get_last_mouse_velocity()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and stick == true:
			drag = event.presed
			if drag == event.pressed and (run == true or mine == true):
				stopRun()
				stopMine()

func _on_area_2d_mouse_entered() -> void:
	stick = true 
func _on_area_2d_mouse_exited() -> void:
	stick = false

func _physics_process(delta: float) -> void:
	if mine == false and run == false:
		if ray_cast_down.is_colliding():
			velocity.y += -SPEED
		if ray_cast_right.is_colliding():
			velocity.x += -SPEED
		if ray_cast_up.is_colliding():
			velocity.y += SPEED
		if ray_cast_left.is_colliding():
			velocity.x += SPEED
	if velocity.x < 0:
		goob_sprite.flip_h = true
		#goob_sprite.animation = "Walking" + shirt
	elif velocity.x >0:
		goob_sprite.flip_h = false
		#goob_sprite.animation = "Walking" + shirt
	else:
		goob_sprite.animation = "Idle" + shirt
	move_and_slide()

func makeMine() -> void:
	mine = true
	velocity = Vector2(0,0)
	collision_shape_2d.set_deferred("disabled", true)
	Globals.miners += 1

func stopMine() -> void:
	mine = false
	collision_shape_2d.set_deferred("disabled", false)
	Globals.miners -= 1

func makeRun() -> void:
	run = true
	velocity = Vector2(0,0)
	collision_shape_2d.set_deferred("disabled", true)
	position = Vector2(randi_range(-200,-290),300)

func stopRun() -> void:
	run = false
	collision_shape_2d.set_deferred("disabled", false)
