extends Area2D

var guy: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		guy = body

func _on_body_exited(body: Node2D) -> void:
	if body == guy:
		guy = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(guy): 
		if guy is CharacterBody2D:
			if guy.drag == false and Globals.miners < Globals.pik_num:
				var miner_guy = guy 
				guy = null
				miner_guy.makeMine()
	else:
		guy = null 
