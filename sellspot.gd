extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is CharacterBody2D:
			if "drag" in body and not body.drag:
				body.queue_free()
				Globals.currency += 1
