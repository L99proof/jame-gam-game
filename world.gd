extends Node2D
@export var drillshape: CollisionShape2D
@export var drill: Sprite2D
@export var drillshape_2: CollisionShape2D
@export var drill_2: Sprite2D
@export var drillshape_3: CollisionShape2D
@export var drill_3: Sprite2D
@export var treadshape: CollisionShape2D
@export var tredmill: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.drill >= 1:
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
