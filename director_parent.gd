extends Node2D
@export var d_spawn_area : Rect2
@export var d_credits : float
@export var d_credit_rate :float
var d_deck_dict = {}

@onready var d_spawn_timer : Node = get_node("Spawn Timer")

func _get_decks(m_deck: Dictionary, r_deck: Dictionary, h_deck: Dictionary, mi_deck: Dictionary) -> void:
	d_deck_dict = {
		"m" : m_deck,
		"r" : r_deck,
		"h" : h_deck,
		"mi" : mi_deck
	}
	
	pass

#func _group_lottery(e_deck : Dictionary) -> Dictionary:
	#var enemy = _enemy_lottery(e_deck)
	#return enemy
	#
#func _enemy_lottery(e_group : Dictionary) -> Array:
	#
	#return e_group[""]
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if d_spawn_timer.is_stopped():
		#var e_wave = _group_lottery(d_deck_dict)
	pass
