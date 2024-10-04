extends Area2D
@export var move_speed = 2000
var direction = Vector2 (1,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("creating bullet")
	await get_tree().create_timer(3).timeout
	queue_free()
	print("bullet destroyed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass

func _on_area_entered(body: Area2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()
	pass # Replace with function body.
