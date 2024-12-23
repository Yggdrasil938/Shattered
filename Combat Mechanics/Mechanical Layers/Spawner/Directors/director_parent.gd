class_name DirectorParent
extends Node2D
## ***DIRECTOR PARENT SCRIPT***
## Director Parent specifies the spawning behavior for enemy chip waves.
## This system is from Risk of Rain 2, 
## I recreated it base on info from the game's wiki.
## Helps ensure enemy waves feel random, dynamic yet fair.
## Parent class is used so 2 seperate spawning entities can be used.



# Exported variables for ease of tuning an debugging.
@export var spawn_area: Rect2 # DOESN'T DO ANYTHING CURRENTLY, SHOULD SET SPAWN AREA FOR DIRECTOR.
@export var spawn_time_range: Array[float] = [1.0, 1.0] # Range of how often waves spawn
@export var credits: float # Credits to buy waves.
@export var credit_rate: float = 1.0 # How many credits per second are granted.
@export var rate_increase: float = 1.0 # How much credit rate increases
@export var difficulty_timer_rate: int = 10 # How often difficulty increases

var shattered_state = false  # Tracks if player has shatttered.

# Loading nodes into variables to help with code readability.
@onready var spawn_timer: Node = get_child(0)
@onready var difficulty_scaling_timer: Node  = get_child(1) 
@onready var current_level:  Node = get_tree().get_first_node_in_group("levels")
# Preloads level deck + color set upon creation.
@onready var level_deck: Dictionary = current_level.level_deck.duplicate()
@onready var level_pane_set: Array[int]  = current_level.level_pane_set
# Creating a random # generator for randomized enemy spawns.
@onready var random_gen = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_gen.randomize() # Values to be filled in child classes.
	credits = 0.0 
	credit_rate = 1.0
	spawn_time_range = [1.0, 1,0]
	rate_increase = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(spawn_timer.time_left)
	credits += (credit_rate/60.0) # Grants credit every frame.


 # Attempt to spawn a wave when spawn timer rings.
func _on_spawn_timeout() -> void:
	_spawn_wave(random_gen.randf_range(spawn_time_range[0], spawn_time_range[1]))
	print("Wave created by director")


# Increase credit rate to scale difficulty when diff timer rings.
func _on_difficulty_timeout() -> void:
	credit_rate += rate_increase
	difficulty_scaling_timer.start(difficulty_timer_rate)
	print(credit_rate)
#####################################################################

func _pool_cards(tickets : int, pool : Array, type : String) -> Array:
	for x in range(0,tickets):
		pool.append(type)
	return pool
	

func _group_lottery(e_deck : Dictionary) -> Dictionary:
	var pool = []
	_pool_cards(e_deck["m"][1], pool, "m")
	_pool_cards(e_deck["r"][1], pool, "r")
	_pool_cards(e_deck["h"][1], pool, "h")
	_pool_cards(e_deck["mb"][1], pool, "mb")
	var winner = e_deck[pool[random_gen.randi_range(0, pool.size()-1)]][0]
	return winner
	
func _enemy_lottery(e_group : Dictionary) -> Array:
	var pool = []
	for x in e_group.keys():
		#print(e_group[x][1])
		_pool_cards(e_group[x][1], pool, x)
	print(pool)
	var winner = pool[random_gen.randi_range(0, pool.size()-1)]
	var wave_amount = credits / e_group[winner][0]
	return [winner,floor(wave_amount)]
	
func _spawn_wave(timer : float) -> void:
	var group = _group_lottery(level_deck)
	var wave = _enemy_lottery(group)
	print(wave)
	print(floor(credits))
	if wave[1] >= 1:
		credits = credits - (wave[1] * group[wave[0]][0])
		print(str("creating wave of ", wave[1], " ", wave[0], "s" ))
		print(str(floor(credits), " remaining credits after wave!"))
		for x in wave[1]:
			var enemy_instance = GlobalConstants.ENEMY_DECK_MASTER[wave[0]].instantiate()
			add_child(enemy_instance)
			var x_range = Vector2(1250, 1920)
			var y_range = Vector2(50, 1030)
			randomize()
			var random_pos = Vector2(randi_range(x_range[0], x_range[1]), randi_range(50, 1030))
			randomize()
			var random_color = randi_range(0, level_pane_set.size()-1)  
			enemy_instance._change_color(level_pane_set[random_color], random_color)
			
			#position=random_pos
			enemy_instance.global_position = random_pos
			spawn_timer.start(timer)
			if shattered_state == true:
				enemy_instance._shattered_aggro()
	else:
		spawn_timer.start(randi_range(2,5))
		print("NOT ENOUGH CREDITS FOR THIS WAVE!")
	pass
		
	
func _aggro_spawn() -> void:
	credit_rate = credit_rate * 2.5
	shattered_state = true
	pass
	
func _aggro_off() -> void:
	credit_rate = credit_rate * .5
	shattered_state = false
	pass
