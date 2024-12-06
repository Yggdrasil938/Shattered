extends "res://Enemy Chips/Shared/chip_parent.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_speed = 450
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass
