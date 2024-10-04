extends Area2D
var layer_color : float =  0
@export var move_speed = 100
var direction = Vector2 (-1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	#print(layer_color)
	pass
	
func _get_layer_color(color_index: float) -> void:
	layer_color = color_index
	pass
	
func _set_layer_color () -> void:
	layer_color = get_node("/root/Main/Camera2D/Control/CanvasLayer").layer_color
	pass


func _on_area_entered(body: Area2D) -> void:
	_set_layer_color()
	if body.is_in_group("bullets") && layer_color == 0:
		print("enemy hit!")
		queue_free()
	pass # Replace with function body.
