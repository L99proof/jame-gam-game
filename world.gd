extends Node2D
@export var drillshape: CollisionShape2D
@export var drill: AnimatedSprite2D
@export var drillshape_2: CollisionShape2D
@export var drill_2: AnimatedSprite2D
@export var drillshape_3: CollisionShape2D
@export var drill_3: AnimatedSprite2D
@export var treadshape: CollisionShape2D
@export var tredmill: Sprite2D
@export var treadmill: Area2D
@export var timer: Timer

var goobs = []
var press
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	press = 0
	timer.start()
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


func _on_button_pressed() -> void:
	goobs.append(preload("res://scenes/goob.tscn").instantiate())
	add_child(goobs.get(press))
	press += 1
