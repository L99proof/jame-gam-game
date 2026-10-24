extends Area2D

var can_drop = false
var guy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	guy = body


func _on_mouse_entered() -> void:
	if guy.drag:
		can_drop = true
	else:
		can_drop = false


func _on_mouse_exited() -> void:
	can_drop = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_drop:
		if guy is CharacterBody2D:
			if guy.drag == false:
				can_drop = false
				guy.makeRun()
				print(4)
