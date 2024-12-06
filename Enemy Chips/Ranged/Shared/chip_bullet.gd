extends "res://Enemy Chips/Shared/chip_parent.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(10).timeout # Bullets last 3 seconds maximum before despawning
	move_speed = 200
	direction = Vector2 (-1,0)
	queue_free()
	pass 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta # Movement Calculation
	pass
