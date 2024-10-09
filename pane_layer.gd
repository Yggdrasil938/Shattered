extends CanvasLayer

var pane_color_index = 0 # Keeps track of what color pane the player is on

# Local variables for referencing nodes, makes changing name and heirarchy much less painful
@onready var current_pane : Node = get_tree().get_first_node_in_group("Pane BG")
@onready var current_level :  Node = get_tree().get_first_node_in_group("levels")
@onready var pane_cooldown : Node = get_tree().get_first_node_in_group("pane cooldown timer")

# Creates an array from the current level node that stores the colors availible and the amount of them
@onready var pane_set: Array[int] = current_level.level_pane_set.duplicate()
@onready var pane_set_size = pane_set.size()

func _convert_int_to_color(index : int):
	var color_string = ""
	match index:
		0:
			color_string = "BLUE" # Water
		1:
			color_string = "RED" # Fire
		2:
			color_string = "YELLOW" # Electric
		3:
			color_string = "DARK_GREEN" # Acid
		4:
			color_string = "DARK_VIOLET" # Gravity
		5:
			color_string = "SADDLE_BROWN" # Earth
		6:
			color_string = "ORANGE" # Sun
		7:
			color_string = "AQUAMARINE" # Ice
		8:
			color_string = "LAWN_GREEN" # Plant
		9:
			color_string = "LIGHT_GRAY" # Wind
		_:
			color_string = "BLACK"
	return color_string

# Changes the background pane color based on the input
func _change_pane(layer : int) -> void:
	var color
	color = _convert_int_to_color(layer)
	current_pane.set_color(color)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_change_pane(pane_set[0]) # Initializes the pane color, first color of the level array is the default
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	 # Whenever the change color button (shift by default) is pressed, change pane if it's off cooldown
	if Input.is_action_pressed("ui_change_color") && pane_cooldown.is_stopped(): 
		pane_color_index += 1
		if pane_color_index > pane_set_size - 1 :
			pane_color_index = 0 # Increments the pane index, if the index size is out of bounds reset to 0
		_change_pane(pane_color_index)
		get_tree().call_group("enemies", "_check_layer_color")
		pane_cooldown.start(1) 
	pass
