extends Area2D

@onready var treadmill_anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if treadmill_anim == null:
		return
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.has_method("makeRun"):
			if "drag" in body and not body.drag:
				if not body.get("run"):
					body.makeRun()
	if Globals.runners > 0:
		treadmill_anim.play("default")
	else:
		treadmill_anim.stop()
