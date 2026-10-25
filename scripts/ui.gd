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
@export var total: Label

var opencloseuithing = 0
var better_pik_cost = 10
var more_pik_cost = 10
var drill_cost = 40
var better_drill_cost = 10
var better_tredmill_efficiency_cost = 200
var max_energy_cost = 10

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
	total.text = str(Globals.currency)
	better_pik_label.text = str(better_pik_cost)
	more_pik_label.text = str(more_pik_cost)
	drill_label.text = str(drill_cost)
	better_drill_label.text = str(better_drill_cost)
	tredmill_efficiency_label.text = str(better_tredmill_efficiency_cost)
	max_energy_label.text = str(max_energy_cost)
	
	if Globals.drill == 3:
		drill.disabled = true
	if Globals.better_pik_num == 4:
		better_pik.disabled = true

func _on_better_pik_pressed() -> void:
	if Globals.currency >= better_pik_cost:
		Globals.better_pik_num += 1
		Globals.pik_speed -= 0.25
		if Globals.pik_speed == 0:
			Globals.pik_speed = 0.01
		better_pik_cost *= 6


func _on_more_pik_pressed() -> void:
	if Globals.currency >= more_pik_cost:
		Globals.pik_num += 1
		more_pik_cost *= 4


func _on_drill_pressed() -> void:
	if Globals.currency >= drill_cost:
		Globals.drill += 1
		if Globals.drill == 1:
			better_drill.visible = true
			tredmill_efficiency.visible = true
			max_energy.visible = true
		drill_cost *= 8


func _on_better_drill_pressed() -> void:
	if Globals.currency >= better_drill_cost:
		Globals.better_drill_num += 1
		Globals.drill_speed -= 0.25
		if Globals.drill_speed == 0:
			Globals.drill_speed = 0.01
		better_drill_cost *=6


func _on_tredmill_efficiency_pressed() -> void:
	if Globals.currency >= better_tredmill_efficiency_cost:
		Globals.tred_eff += 1
		Globals.energy_per_goob = 10
		tredmill_efficiency.disabled = true


func _on_max_energy_pressed() -> void:
	if Globals.currency >= max_energy_cost:
		Globals.max_energy += 50
		max_energy_cost *= 2


func _on_open_close_pressed() -> void:
	opencloseuithing = 1 - opencloseuithing
	if opencloseuithing == 0:
		collapsebutton.set_text("⌃")
	if opencloseuithing == 1:
		collapsebutton.set_text("⌄")
