extends Control
@export var better_pik_label: Label
@export var better_pik: Button
@export var more_pik_label: Label
@export var more_pik: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	better_pik_label.text = str(Globals.better_pik_num)
	more_pik_label.text = str(Globals.pik_num)


func _on_better_pik_pressed() -> void:
	Globals.better_pik_num += 1


func _on_more_pik_pressed() -> void:
	Globals.pik_num += 1
