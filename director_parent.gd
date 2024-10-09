extends Node2D
var c_enemy = preload("res://Chip.tscn")

@export var d_spawn_area : Rect2
@export var d_credits : float
@export var d_credit_rate : float = 4

@onready var d_spawn_timer : Node = get_node("Slow Director/Spawn Timer")
@onready var current_level :  Node = get_tree().get_first_node_in_group("levels")

var random = RandomNumberGenerator.new()


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
		_pool_cards(e_group[x][1], pool, x)
	var winner = pool[random.randi_range(0, pool.size()-1)]
	var wave_amount = d_credits / e_group[winner][1]
	return [winner,floor(wave_amount)]
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()
	d_credits = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(d_spawn_timer.time_left)
	d_credits += (d_credit_rate/60)
	if d_spawn_timer.is_stopped():
		var group = _group_lottery(d_deck_dict)
		var wave = _enemy_lottery(group)
		print(wave)
		print(floor(d_credits))
		if wave[1] >= 1:
			d_credits = d_credits - (wave[1] * group[wave[0]][1])
			print(str("creating wave of ", wave[1], " ", wave[0], "s" ))
			print(str(floor(d_credits), " remaining credits after wave!"))
			for x in wave[1]:
				var enemy_instance = c_enemy.instantiate()
				#print("created enemy")
				get_tree().root.add_child(enemy_instance)
				randomize()
				var x_range = Vector2(1250, 1920)
				var y_range = Vector2(50, 1030)

			#enemy_instance._get_layer_color(current_pane.pane_color_index)
				var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
				var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
				var random_pos = Vector2(random_x, random_y)
				var random_color = randi_range(0, 1)
				enemy_instance._change_color(random_color)
		
				position=random_pos
				enemy_instance.global_position = position
			d_spawn_timer.start()
		else:
			d_spawn_timer.start()
			print("NOT ENOUGH CREDITS FOR THIS WAVE!")
		
	pass
