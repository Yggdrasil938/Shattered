extends Polygon2D

# Movement default values 

var p_move_speed = 400 
var p_angular_speed = PI
var p_velocity = Vector2.ZERO
var p_sprite_rotation = 0
var p_reorient_speed = 0
var p_input_key = "x" # This is set to x since null pointers cause issues, x is treated as no input


# Instantiating scenes for instance spawning

var p_bullet = preload("res://bullet.tscn") 

func _input(event): # Extracts the event string from inputs for use in a match statement
	var p_action = "x"
	for input in InputMap.get_actions():
		if InputMap.event_is_action(event, input):
			p_action = input
	if p_action:
		p_input_key = p_action
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released(p_input_key) && Input.is_anything_pressed() != true: # Once an action is released, key is changed to stop actions
		print("yooooooo")
		p_input_key ="x"
	
	match p_input_key: # Input match statement, inputs get used to perform player movement.		
		"ui_move_right":
			if Input.is_action_pressed("ui_move_up"):
				p_velocity = Vector2.RIGHT.rotated(-45) * p_move_speed
				p_sprite_rotation = .075
			elif Input.is_action_pressed("ui_move_down"):
				p_velocity = Vector2.RIGHT.rotated(45) * p_move_speed
				p_sprite_rotation = -.075
			elif Input.is_action_pressed("ui_move_left"):
				p_velocity = Vector2.RIGHT.rotated(0) * 0
				if rotation != 0:
					p_sprite_rotation = - rotation / 2
			elif Input.is_action_just_released("ui_move_right"):
				p_velocity = Vector2.RIGHT.rotated(0) * p_move_speed
			else:
				p_velocity = Vector2.RIGHT.rotated(0) * p_move_speed
			if rotation != 0:
				p_sprite_rotation = - rotation / 2

		
		"ui_move_left":
			if Input.is_action_pressed("ui_move_up"):
				p_velocity = Vector2.LEFT.rotated(45) * p_move_speed
				p_sprite_rotation = .075
			elif Input.is_action_pressed("ui_move_down"):
				p_velocity = Vector2.LEFT.rotated(-45) * p_move_speed
				p_sprite_rotation = -.075
			elif Input.is_action_pressed("ui_move_right"):
				p_velocity = Vector2.LEFT.rotated(0) * 0
				if rotation != 0:
					p_sprite_rotation = - rotation / 2
			else:
				p_velocity = Vector2.LEFT.rotated(0) * p_move_speed
			if rotation != 0:
				p_sprite_rotation = - rotation / 2
			
		"ui_move_up":
			if Input.is_action_pressed("ui_move_left"):
				p_velocity = Vector2.UP.rotated(-45) * p_move_speed
				p_sprite_rotation = .075
			elif Input.is_action_pressed("ui_move_right"):
				p_velocity = Vector2.UP.rotated(45) * p_move_speed
				p_sprite_rotation = .075
			elif Input.is_action_pressed("ui_move_down"):
				p_velocity = Vector2.UP.rotated(0) * 0
				if rotation != 0:
					p_sprite_rotation = - rotation / 2
			else:
				p_velocity = Vector2.UP.rotated(0) * p_move_speed
				p_sprite_rotation = .10 # Sprite is rotated when moving up and down to give the illusion of momentum
				
		"ui_move_down":
			if Input.is_action_pressed("ui_move_left"):
				p_velocity = Vector2.DOWN.rotated(45) * p_move_speed
				p_sprite_rotation = -.075
			elif Input.is_action_pressed("ui_move_right"):
				p_velocity = Vector2.DOWN.rotated(-45) * p_move_speed
				p_sprite_rotation = -.075
			elif Input.is_action_pressed("ui_move_up"):
				p_velocity = Vector2.DOWN.rotated(0) * 0
				if rotation != 0:
					p_sprite_rotation = - rotation / 2
			else:
				p_velocity = Vector2.DOWN.rotated(0) * p_move_speed
				p_sprite_rotation = -.10
		"x":
			p_velocity = Vector2.ZERO # Stops player movement when no longr holding keys
			if rotation != 0:
				p_sprite_rotation = - rotation / 2
			
	rotation += p_angular_speed * p_sprite_rotation * delta # Rotates sprite 
	position += p_velocity * delta # Translates Sprite
	
	if Input.is_action_pressed("ui_shoot") && get_node("Shooting Timer").is_stopped():
		var bullet_instance = p_bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = get_node("Marker2D").global_position
		get_node("Shooting Timer").start()
		
	#Adapted code from the godot docs, will fine tune later
	pass
