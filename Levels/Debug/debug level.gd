extends Node2D

# For creating instances of mechanical layers on level start
@onready var pane_painter = preload("res://Combat Mechanics/Mechanical Layers/Painter/pane_painter.tscn")
@onready var combat_layer = preload("res://Combat Mechanics/Mechanical Layers/Spawner/chip_spawner.tscn")

# Set of color panes in the current level by index
#var level_pane_set: Array[int] = [0,1]
#var level_pane_set: Array[int] = [0,1,2,3,4,5,6,7,8,9] 
var level_pane_set: Array[int] = [0,1,3,4] 
 
# Set of enemy decks in current level
# [0] is the enemy price, [1] is how many "tickets" it puts in the lottery
var melee_deck: Dictionary = {"chip": [3,3], "fast_chip": [5,2], "chip_angle": [2,2]} 
#var melee_deck: Dictionary = {"chip": [3,3], "fast_chip": [.1,500], "chip_angle": [2,2]} 
var ranged_deck: Dictionary = {"chip_shoot": [4, 2]}
var hazard_deck: Dictionary = {}
var miniboss_deck: Dictionary = {}

# Level deck contains all of the enemy group decks along with the group ticket #
var level_deck: Dictionary = {"m" : [melee_deck, 2], "r" : [ranged_deck, 1] , "h" : [hazard_deck, 0], "mb" : [miniboss_deck, 0]}
#var level_deck: Dictionary = {"m" : [melee_deck, 1], "r" : [ranged_deck, 100] , "h" : [hazard_deck, 0], "mb" : [miniboss_deck, 0]}

# Instantiates pane painter layer and combat layer to start the level
func _level_startup() -> void:  
	var painter_instance = pane_painter.instantiate()
	add_child(painter_instance)
	var combat_l_instance = combat_layer.instantiate()
	add_child(combat_l_instance)
	pass
	
func _restart() -> void:
	var current_cl : Node = get_tree().get_first_node_in_group("combat layer")
	remove_child(current_cl)
	var current_ccl :  Node = get_tree().get_first_node_in_group("Color Change Layer")
	remove_child(current_ccl)
	_level_startup()
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_startup() # Starts level
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_restart"):
		_restart()
	pass
