extends DirectorParent



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_gen.randomize() # Creates a new random seed on startup.
	credit_rate = 1
	spawn_time_range = [8.0, 15,0]
	rate_increase = .5
