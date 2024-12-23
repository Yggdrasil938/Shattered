extends "res://Enemy Chips/Shared/chip_parent.gd"
var random = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_speed = 200
	random.randomize()
	var x = random.randi_range(0, 1)
	if x == 0:
		random.randomize()
		direction[1] = random.randf_range(-.65, -.15)
	else:
		random.randomize()
		direction[1] = random.randf_range(.15, .65)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass
