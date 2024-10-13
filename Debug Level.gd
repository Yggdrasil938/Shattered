extends Node2D

# Set of color panes in the current level by index
#var level_pane_set: Array[int] = [0,1]
var level_pane_set: Array[int] = [0,1,3,4] 
#var level_pane_set: Array[int] = [0,1,2,3,4,5,6,7,8,9] 

# Set of enemy decks in current level
# [0] is the enemy price, [1] is how many "tickets" it puts in the lottery
var melee_deck: Dictionary = {"chip": [3,3], "fast_chip": [5,2], "chip_angle": [2,2]} 
#var melee_deck: Dictionary = {"chip": [3,3], "fast_chip": [.1,500], "chip_angle": [2,2]} 
var ranged_deck: Dictionary = {"chip_shoot": [4, 2]}
var hazard_deck: Dictionary = {}
var miniboss_deck: Dictionary = {}

# Level deck contains all of the enemy group decks
var level_deck: Dictionary = {"m" : [melee_deck, 2], "r" : [ranged_deck, 1] , "h" : [hazard_deck, 0], "mb" : [miniboss_deck, 0]}
#var level_deck: Dictionary = {"m" : [melee_deck, 1], "r" : [ranged_deck, 100] , "h" : [hazard_deck, 0], "mb" : [miniboss_deck, 0]}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
