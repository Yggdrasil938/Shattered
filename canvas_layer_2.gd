extends CanvasLayer
var c_enemy = preload("res://Chip.tscn")
var position: Vector2
@onready var current_pane : Node = get_tree().get_first_node_in_group("Color Change Layer")

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
		var x_range = Vector2(1250, 1920)
		var y_range = Vector2(50, 1030)

		enemy_instance._get_layer_color(current_pane.pane_color_index)
		var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
		var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
		var random_pos = Vector2(random_x, random_y)
		var random_color = randi_range(0, 1)
		enemy_instance._change_color(random_color)
		
		position=random_pos
		enemy_instance.global_position = position

		get_node("Enemy Spawn Timer").start()
	pass
