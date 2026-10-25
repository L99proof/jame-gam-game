extends CharacterBody2D
@export var ray_cast_left: RayCast2D
@export var ray_cast_down: RayCast2D
@export var ray_cast_up: RayCast2D
@export var ray_cast_right: RayCast2D
@export var collision_shape_2d: CollisionShape2D
@export var area_2d: Area2D
@export var goob_sprite: AnimatedSprite2D

var stick = true
var drag = false
var mine = false
var run = false
var color = randi_range(1,6)
var shirt = "Blue"
@export var limit_min: Vector2 = Vector2(-2000, -2000)
@export var limit_max: Vector2 = Vector2(2000, 2000)
@onready var parent = get_parent() as PathFollow2D
@export var LowSpeed:float = 60.0
@export var HighSpeed:float = 100.0
@export var pace_small_size:float = 100
@export var pace_big_size:float = 300 
@export var da_friction:float = 4
@export var tredmill: AnimatedSprite2D

var SPEED:float
var home_position                  
var target_position                
var is_waiting = false                
var wait_timer = 0.0                 
var toss = false

func _ready() -> void:
	SPEED = randf_range(LowSpeed, HighSpeed)
	home_position = global_position
	choose_new_pace_target()
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
func _process(delta: float) -> void:
	if drag and not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		release_object()
	
	if drag:
		var target_pos = get_global_mouse_position().clamp(limit_min, limit_max)
		velocity = (target_pos - global_position) / delta
		global_position = target_pos



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			if stick and is_mouse_over_me():
				drag = true
				toss = false
				if run:
					stopRun()
				if mine:
					stopMine()
		elif drag:
			release_object()

func is_mouse_over_me() -> bool:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.collision_mask = 0xFFFFFFFF

	var hits := get_world_2d().direct_space_state.intersect_point(query, 32)
	for hit in hits:
		var collider = hit.get("collider")
		if collider == self or collider == area_2d:
			return true
	return false

func release_object() -> void:
	drag = false
	toss = true
	collision_shape_2d.set_deferred("disabled", false)

func _physics_process(delta: float) -> void:
	if not drag:
		if toss:	
			velocity = velocity.move_toward(Vector2(0,0), da_friction * SPEED * delta)
			if is_on_wall() or velocity.length() < 10.0:
				toss = false
				home_position = global_position
				choose_new_pace_target()
		elif mine == false and run == false:
			if is_waiting:
				velocity = Vector2(0,0)
				wait_timer -= delta
				if wait_timer <= 0:
					is_waiting = false
					choose_new_pace_target()
			else:
				var direction = (target_position - global_position).normalized()
				velocity = direction * SPEED
				if global_position.distance_to(target_position) < 10.0:
					start_waiting()
			if ray_cast_down.is_colliding() or ray_cast_right.is_colliding() or ray_cast_up.is_colliding() or ray_cast_left.is_colliding():
				choose_new_pace_target()
		move_and_slide()
	if mine == false:
		if velocity.length() > 5.0:
			if velocity.x < 0:
				goob_sprite.flip_h = true
			elif velocity.x > 0:
				goob_sprite.flip_h = false
		else:
			goob_sprite.animation = "Idle" + shirt
	elif mine == true:
		if velocity.length() > 5.0:
			if velocity.x < 0:
				goob_sprite.flip_h = true
			elif velocity.x > 0:
				goob_sprite.flip_h = false
		else:
			goob_sprite.animation = "Idle" + "Mine" + shirt
		velocity = velocity.move_toward((target_position-global_position),SPEED * 0.5)

func choose_new_pace_target() -> void:
	var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var distance = randf_range(pace_small_size, pace_big_size)
	target_position = home_position + (direction * distance)
	target_position = target_position.clamp(limit_min, limit_max)

func start_waiting() -> void:
	is_waiting = true
	wait_timer = randf_range(1.5, 4.0)

func makeMine() -> void:
	mine = true
	toss= false
	velocity = Vector2(0,0)
	collision_shape_2d.set_deferred("disabled", true)
	Globals.miners += 1
	target_position = Vector2(randf_range(-590,-580), randf_range(-1140,-452))
	
	while mine == true:
		rotation = deg_to_rad(0)
		await get_tree().create_timer(0.5).timeout
		if not mine: 
			break
		rotation = deg_to_rad(45)
		await get_tree().create_timer(0.5).timeout

func stopMine() -> void:
	mine = false
	home_position = global_position
	choose_new_pace_target()
	collision_shape_2d.set_deferred("disabled", false)
	Globals.miners -= 1

func makeRun() -> void:
	run = true
	toss = false
	velocity = Vector2(0,0)
	collision_shape_2d.set_deferred("disabled", true)
	position = Vector2(randi_range(-1856,-1405), randi_range(-150,55))
	Globals.runners += 1


func stopRun() -> void:
	run = false
	home_position = global_position
	choose_new_pace_target()
	collision_shape_2d.set_deferred("disabled", false)
	Globals.runners -= 1
