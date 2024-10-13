extends Node2D
var enemy_load_deck : Dictionary = {"chip" : preload("res://Chip.tscn"), "fast_chip" : preload("res://fast_chip.tscn"), "chip_angle" : preload("res://chip_angle.tscn"), "chip_shoot" : preload("res://chip_shoot.tscn")}


@export var d_spawn_area : Rect2
@export var d_credits : float
@export var d_credit_rate : float = 1

@onready var d_spawn_timer : Node = get_child(0)
@onready var current_level :  Node = get_tree().get_first_node_in_group("levels")

var random = RandomNumberGenerator.new()
@onready var difficulty_scaling = get_child(0) 

@onready var d_deck_dict: Dictionary = current_level.level_deck.duplicate()

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
	var winner = e_deck[pool[random.randi_range(0, pool.size()-1)]][0]
	return winner
	
func _enemy_lottery(e_group : Dictionary) -> Array:
	var pool = []
	for x in e_group.keys():
		#print(e_group[x][1])
		_pool_cards(e_group[x][1], pool, x)
	print(pool)
	var winner = pool[random.randi_range(0, pool.size()-1)]
	var wave_amount = d_credits / e_group[winner][0]
	return [winner,floor(wave_amount)]
	
func _spawn_wave(timer : float) -> void:
	var group = _group_lottery(d_deck_dict)
	var wave = _enemy_lottery(group)
	print(wave)
	print(floor(d_credits))
	if wave[1] >= 1:
		d_credits = d_credits - (wave[1] * group[wave[0]][0])
		print(str("creating wave of ", wave[1], " ", wave[0], "s" ))
		print(str(floor(d_credits), " remaining credits after wave!"))
		for x in wave[1]:
			var enemy_instance = enemy_load_deck[wave[0]].instantiate()
			#print("created enemy")
			get_tree().root.add_child(enemy_instance)
			randomize()
			var x_range = Vector2(1250, 1920)
			var y_range = Vector2(50, 1030)

			#enemy_instance._get_layer_color(current_pane.pane_color_index)
			var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
			var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
			var random_pos = Vector2(random_x, random_y)
			var random_color = randi_range(0, current_level.level_pane_set.size()-1)  
			enemy_instance._change_color(current_level.level_pane_set[random_color], random_color)
		
			position=random_pos
			enemy_instance.global_position = position
			d_spawn_timer.start(timer)
	else:
		d_spawn_timer.start(2,5)
		print("NOT ENOUGH CREDITS FOR THIS WAVE!")
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()
	d_credits = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(d_spawn_timer.time_left)
	d_credits += (d_credit_rate/60)
	#if d_spawn_timer.is_stopped():
		#_spawn_wave()
	if difficulty_scaling.is_stopped():
		d_credit_rate += .75
		difficulty_scaling.start()
		print(d_credit_rate)
	pass
