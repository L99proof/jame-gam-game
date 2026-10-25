extends Node2D
@export var drillshape: CollisionShape2D
@export var drill: AnimatedSprite2D
@export var drillshape_2: CollisionShape2D
@export var drill_2: AnimatedSprite2D
@export var drillshape_3: CollisionShape2D
@export var drill_3: AnimatedSprite2D
@export var treadshape: CollisionShape2D
@export var tredmill: AnimatedSprite2D
@export var treadmill: Area2D
@export var timer: Timer
@export var click_cooldown: Timer
@export var drill_time: Timer

var goobs = []
var goobs2 = []
var goobSpawn2 = []
var press
var press2
var can_click = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drill_time.start(Globals.drill_speed)
	press2 = 0
	press = 0
	goobSpawn2.append(Vector2(-1710,-961))
	goobSpawn2.append(Vector2(-1710,-760))
	goobSpawn2.append(Vector2(-1695,-550))
	timer.start(1)
	drill.play("default")
	drill_3.play("default")
	drill_2.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.drill >= 1:
		treadmill.set_deferred("monitoring", true)
		treadshape.set_deferred("disabled", false)
		tredmill.set_deferred("visible", true)
		drillshape.set_deferred("disabled", false)
		drill.set_deferred("visible", true)
	if Globals.drill >= 2:
		drillshape_2.set_deferred("disabled", false)
		drill_2.set_deferred("visible", true)
	if Globals.drill >= 3:
		drillshape_3.set_deferred("disabled", false)
		drill_3.set_deferred("visible", true)


func _on_timer_timeout() -> void:
	if Globals.current_energy < Globals.max_energy:
		Globals.current_energy += (Globals.energy_per_goob * Globals.runners)
	elif Globals.current_energy > Globals.max_energy:
		Globals.current_energy = 100
	else:
		pass
	timer.start(1)
func _on_click_cooldown_timeout() -> void:
	can_click = true

func _on_button_pressed() -> void:
	if can_click:
		for x in range(0,Globals.miners):
			goobs.append(preload("res://scenes/goob.tscn").instantiate())
			goobs.get(press).position = Vector2(randf_range(-590,-580), randf_range(-452,-1140))
			add_child(goobs.get(press))
			x += 1
			press += 1
			can_click = false
			click_cooldown.start(Globals.pik_speed)


func _on_sell_button_pressed() -> void:
	for child in get_children():
		if child is CharacterBody2D:
			if not child.run and not child.mine:
				child.queue_free()
				Globals.currency += 1


func _on_drill_time_timeout() -> void:
	for z in range(0,Globals.drill):
		if Globals.current_energy >= 50:
			Globals.current_energy -= 50
			goobs2.append(preload("res://scenes/goob.tscn").instantiate())
			goobs2.get(press2).position = goobSpawn2.get(randi_range(0,Globals.drill-1))
			add_child(goobs2.get(press2))
			press2 += 1
		z+=1
	drill_time.start(Globals.drill_speed)
