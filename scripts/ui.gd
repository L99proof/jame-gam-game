extends Control
@export var better_pik_label: Label
@export var better_pik: Button
@export var more_pik_label: Label
@export var more_pik: Button
@export var drill_label: Label
@export var drill: Button
@export var better_drill_label: Label
@export var more_drill_label: Label
@export var more_drill: Button
@export var better_drill: Button
@export var tredmill_efficiency_label: Label
@export var tredmill_efficiency: Button
@export var collapsebutton: Button
@export var collapsible: CollapsibleContainer
@export var max_energy: Button
@export var max_energy_label: Label

var opencloseuithing = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Create button to toggle the collapsible
	collapsebutton.set_text("^")
	collapsebutton.connect("pressed", collapsible.toggle_tween) # Connect signal to collapsible
	add_child(collapsebutton)

	add_child(collapsible)
	collapsible.set_folding_direction_preset(CollapsibleContainer.FoldingPreset.PRESET_TOP_WIDE)
	collapsible.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	better_drill.visible = false
	tredmill_efficiency.visible = false
	max_energy.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	better_pik_label.text = str(Globals.better_pik_num)
	more_pik_label.text = str(Globals.pik_num-1)
	drill_label.text = str(Globals.drill)
	better_drill_label.text = str(Globals.better_drill_num)
	tredmill_efficiency_label.text = str(Globals.tred_eff)
	max_energy_label.text = str((Globals.max_energy/50)-2)
	
	if Globals.drill == 3:
		drill.disabled = true

func _on_better_pik_pressed() -> void:
	Globals.better_pik_num += 1


func _on_more_pik_pressed() -> void:
	Globals.pik_num += 1


func _on_drill_pressed() -> void:
	Globals.drill += 1
	if Globals.drill >= 1:
		better_drill.visible = true
		tredmill_efficiency.visible = true
		max_energy.visible = true


func _on_better_drill_pressed() -> void:
	Globals.better_drill_num += 1

func _on_tredmill_efficiency_pressed() -> void:
	Globals.tred_eff += 1


func _on_open_close_pressed() -> void:
	opencloseuithing = 1 - opencloseuithing
	if opencloseuithing == 0:
		collapsebutton.set_text("⌃")
	if opencloseuithing == 1:
		collapsebutton.set_text("⌄")


func _on_max_energy_pressed() -> void:
	Globals.max_energy += 50
