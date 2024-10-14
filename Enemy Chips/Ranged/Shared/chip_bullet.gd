extends "res://chip_main.gd"

# Initialization values
move_speed = 200
direction = Vector2 (-1,0)

func _change_color (spawn_color: int) -> void:
	var color_str = current_pane._convert_int_to_color(spawn_color)
	get_child(0).set_color(color_str)
	e_color = spawn_color
	_check_layer_color()
	#print (color_str)
	#print(e_color)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(10).timeout # Bullets last 3 seconds maximum before despawning
	queue_free()
	pass 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta # Movement Calculation
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		print("player hit!")
		body.queue_free()
		queue_free()
	pass
