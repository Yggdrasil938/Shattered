extends CanvasLayer
var layer_color = 0 # Keeps track of what color pane the player is on

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_node("Changing Timer").time_left)
	
	
	if Input.is_action_pressed("ui_change_color") && get_node("Changing Timer").is_stopped(): # Whenever the change color button (shift by default) is pressed
		if layer_color == 0:
			layer_color = 1
			get_node("Blue BG").set_visible(false)
			get_node("Red BG").set_visible(true)
			#print("Changing to blue")
			get_node("Changing Timer").start(5)
			# Checks the layer color, flips it, changes BG visibility and starts a cooldown timer
			#This is poorly done currently, need a better indexing system and switch statement. Good for now. :3
		
		
		else:
			layer_color = 0
			get_node("Blue BG").set_visible(true)
			get_node("Red BG").set_visible(false )
			#print("Changing to red")
			get_node("Changing Timer").start(5)
	pass
