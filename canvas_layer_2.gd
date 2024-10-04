extends CanvasLayer
var c_enemy = preload("res://red chip.tscn")
var position: Vector2
#var blue : Vector4 = (10, 275, 30, 255)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_node("Enemy Spawn Timer").is_stopped():
		var enemy_instance = c_enemy.instantiate()
		print("created enemy")
		get_tree().root.add_child(enemy_instance)
		randomize()
		var x_range = Vector2(100, 750)
		var y_range = Vector2(100, 750)

		var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
		var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
		var random_pos = Vector2(random_x, random_y)

		#enemy_instance.get_node("Chip Sprite").set_color(blue)
		position=random_pos
		enemy_instance.global_position = position
		enemy_instance._get_layer_color(get_node("../CanvasLayer").layer_color)
		get_node("Enemy Spawn Timer").start()
	pass
