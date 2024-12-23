extends Node2D
## ***DEBUG LEVEL SCRIPT***
## Contains enemy decks and pane sets used for testing purposes.



# Set of enemy decks in current level
# [0] is the enemy price, [1] is how many "tickets" it puts in the lottery
var melee_deck: Dictionary = {
	"chip": [3, 3],
	"fast_chip": [5, 2],
	"chip_angle": [2, 2],
 }
#var melee_deck: Dictionary = {
	#"chip": [3,3],
	#"fast_chip": [.1,500],
	#"chip_angle": [2,2],
#}
var ranged_deck: Dictionary = { "chip_shoot": [4, 2] }
var hazard_deck: Dictionary = {}
var miniboss_deck: Dictionary = {}

# Level deck contains all group dicts and corresponding ticket value.
var level_deck: Dictionary = { 
	"m": [melee_deck, 2],
	"r": [ranged_deck, 1],
	"h": [hazard_deck, 0],
	"mb": [miniboss_deck, 0],
}
#var level_deck: Dictionary = { 
	#"m": [melee_deck, 1],
	#"r": [ranged_deck, 100],
	#"h": [hazard_deck, 0],
	#"mb": [miniboss_deck, 0],
#}

# Set of color panes in the current level by index.
#var level_pane_set: Array[int] = [0, 1]
#var level_pane_set: Array[int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] 
var level_pane_set: Array[int] = [0, 1, 3, 4]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level_startup() # Instantiates game systems to start the level.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_restart"): # Bound to "R", restarts level.
		_restart()


# Instantiates Pane Painter layer and Chip Spawner layer to start the level.
func _level_startup() -> void:  
	var painter_instance = GlobalConstants.PANE_PAINTER.instantiate()
	add_child(painter_instance)
	
	var chip_instance = GlobalConstants.CHIP_SPAWNER.instantiate()
	add_child(chip_instance)


# Destroys all mechanical layers and creates new ones to reatart level
func _restart() -> void:
	var current_chip_spawner: Node = (
			get_tree().get_first_node_in_group("chip_spawner"))
	remove_child(current_chip_spawner)
	
	var current_pane_painter: Node = (
			get_tree().get_first_node_in_group("pane_painter"))
	remove_child(current_pane_painter)
	
	_level_startup()
