extends Node2D
var level_pane_set: Array[int] = [0,1] # Just red and blue for now
var melee_deck: Dictionary = {"chip": [1, 10]}
var ranged_deck: Dictionary = {}
var hazard_deck: Dictionary = {}
var miniboss_deck: Dictionary = {}

var level_deck: Dictionary = {"m" : [melee_deck, 1], "r" : [ranged_deck, 0] , "h" : [hazard_deck, 0], "mb" : [miniboss_deck, 0]}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass
