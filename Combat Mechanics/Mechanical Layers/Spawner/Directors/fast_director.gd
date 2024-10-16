extends "res://Combat Mechanics/Mechanical Layers/Spawner/Directors/director_parent.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	d_credit_rate = 3
	difficulty_scaling = get_child(1) 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	d_credits += (d_credit_rate/60)
	if d_spawn_timer.is_stopped():
		print("Wave created by fast director")
		_spawn_wave(random.randi_range(2,5))
	if difficulty_scaling.is_stopped():
		d_credit_rate += .25
		#d_credit_rate += 3
		difficulty_scaling.start()
		print(d_credit_rate)
	pass
