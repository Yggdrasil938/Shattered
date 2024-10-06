extends Area2D
var layer_color : float =  0
@export var move_speed = 100
var e_color = 0
var direction = Vector2 (-1,0)
@onready var current_pane : Node = get_tree().get_first_node_in_group("Color Change Layer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass
	
func _get_layer_color(color_index: float) -> void:
	layer_color = color_index
	pass

func _change_color (spawn_color: int) -> void:
	print(spawn_color)
	match spawn_color:
		1:
			print("color is blue")
			get_node("Chip Sprite").set_color("AQUA")
			e_color = 1
		0:
			e_color = 0
	pass
	
func _check_layer_color () -> void:
	layer_color = current_pane.layer_color
	pass


func _on_area_entered(body: Area2D) -> void:
	_check_layer_color()
	if body.is_in_group("bullets") && layer_color == e_color:
		print("enemy hit!")
		body.queue_free()
		queue_free()
	pass # Replace with function body.
