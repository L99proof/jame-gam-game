extends Camera2D

var clicknotclick = 0
var clicknotclickpos = 0
var clickmovepos = 0
var movement = 0
var movementx =0
var movementy = 0
var drag = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			drag = event.pressed
	if event is InputEventMouseMotion and drag:
		move_local_x(-event.relative.x)
		move_local_y(-event.relative.y)

		#print("Mouse Motion at: ", event.position)
	## Print the size of the viewport.
		#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
