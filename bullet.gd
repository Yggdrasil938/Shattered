extends Area2D


# Initialization values
@export var move_speed = 2000
@export var direction = Vector2 (1,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3).timeout # Bullets last 3 seconds maximum before despawning
	queue_free()
	pass 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta # Movement Calculation
	pass
