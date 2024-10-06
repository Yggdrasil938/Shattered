extends Area2D
@export var move_speed = 2000
var direction = Vector2 (1,0)
var layer_color = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("creating bullet")
	await get_tree().create_timer(3).timeout
	queue_free()
	print("bullet destroyed")
	pass # Replace with function body.
	
func _set_layer_color () -> void:
	layer_color = get_node("/root/Main/Camera2D/Control/CanvasLayer").layer_color
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass
