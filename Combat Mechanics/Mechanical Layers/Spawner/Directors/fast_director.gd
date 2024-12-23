extends DirectorParent



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_gen.randomize() # Creates a new random seed on startup.
	credit_rate = 3
	spawn_time_range = [2.0, 5,0]
	rate_increase = .25
