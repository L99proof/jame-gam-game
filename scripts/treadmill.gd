extends Area2D
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is CharacterBody2D:
			if "drag" in body and not body.drag:
				if body.has_method("makeRun"):
					body.makeRun()
