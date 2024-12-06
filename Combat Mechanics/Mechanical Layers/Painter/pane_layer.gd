extends CanvasLayer


var pane_color_index = 0 # Keeps track of what color pane the player is on
var pane_ammo: Array[int] = [20,20,20,20,20,20,20,20,20,20,20] # Initialize all to 20 ammo

# Local variables for referencing nodes, makes changing name and heirarchy much less painful
@onready var current_pane : Node = get_tree().get_first_node_in_group("Pane BG")
@onready var current_level :  Node = get_tree().get_first_node_in_group("levels")
@onready var pane_cooldown : Node = get_tree().get_first_node_in_group("pane cooldown timer")
@onready var camera : Node = get_tree().get_first_node_in_group("camera main")
@onready var invuln_cooldown : Node = get_child(5)
@onready var slowd_timer : Node = get_child(4)

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
	get_child(3).set_value_no_signal(pane_ammo[pane_color_index])
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_change_pane(pane_set[0]) # Initializes the pane color, first color of the level array is the default
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	 # Whenever the change color button (shift by default) is pressed, change pane if it's off cooldown
	get_child(3).set_value_no_signal(pane_ammo[pane_color_index])
	if pane_ammo[pane_color_index] <= 10:
		get_child(3).tint_under = "GREY"
	else:  
		get_child(3).tint_under = "WHITE"
	if pane_ammo[pane_color_index] == 0:
		get_tree().call_group("player", "_shattered")
		pane_ammo[pane_color_index] = 20
	if Input.is_action_pressed("ui_change_color") && pane_cooldown.is_stopped(): 
		if pane_ammo[pane_color_index] <= 10:
			get_tree().get_first_node_in_group("player camera")._set_zoom_target(1.5, 4)
			Engine.time_scale = .2
			get_tree().get_first_node_in_group("player").p_invuln = true
			invuln_cooldown.start()
			slowd_timer.start()
			match pane_color_index:
				1:
					get_tree().call_group("enemies","_reduce_movement")
				0:
					get_tree().call_group("player","_attack_speed_buff")
		pane_color_index += 1
		if pane_color_index > pane_set_size - 1 :
			pane_color_index = 0 # Increments the pane index, if the index size is out of bounds reset to 0
		_change_pane(pane_set[pane_color_index])
		get_tree().call_group("enemies", "_check_layer_color")
		
		pane_cooldown.start(1) 
	pass


func _on_ammo_reload_rate_timeout() -> void:
	for x in pane_ammo.size():
		if pane_ammo[x] < 19 && x != pane_color_index:
			pane_ammo[x] += 1
	pass # Replace with function body.


func _on_slow_down_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().get_first_node_in_group("player camera")._set_zoom_target(1 , 10)
	pass # Replace with function body.


func _on_invuln_timer_timeout() -> void:
	get_tree().get_first_node_in_group("player").p_invuln = false
	pass # Replace with function body.
