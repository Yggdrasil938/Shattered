extends Area2D
var layer_color : float =  0
@export var move_speed = 150
var e_color = 0
var direction = Vector2 (-1,0)
@onready var current_pane : Node = get_tree().get_first_node_in_group("pane_painter")
@onready var player : Node = get_tree().get_first_node_in_group("player")

var shattered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * move_speed * delta
	pass
	
func _get_layer_color(color_index: float) -> void:
	layer_color = color_index
	pass
	
func _reduce_movement() -> void:
	move_speed =  move_speed * .1
	get_child(2).emitting = true
	get_child(2).color = Color("LIGHT_SKY_BLUE")
	pass

func _change_color (spawn_color: int, color_index : int) -> void:
	var color_str = current_pane._convert_int_to_color(spawn_color)
	get_child(0).set_color(color_str)
	e_color = color_index
	_check_layer_color()
	#print (color_str)
	#print(e_color)
	pass
	
func _check_layer_color () -> void:
	layer_color = current_pane.pane_color_index
	if layer_color == e_color:
		get_child(2).emitting = true
		get_child(0).visible = false
	else:
		if get_child(2).color != Color("LIGHT_SKY_BLUE"):
			get_child(2).emitting = false
		get_child(0).visible = true
	pass


func _on_area_entered(body: Area2D) -> void:
	if body.is_in_group("bullets") && layer_color != e_color:
		print("enemy hit!")
		body.queue_free()
		queue_free()
	pass # Replace with function body.


# Checks for player collisions, destroy player if touching
func _on_body_entered(body: CharacterBody2D) -> void:
	_check_layer_color()
	if body.is_in_group("player") && layer_color != e_color && player.p_invuln != true:
		print("player hit!")
		body.queue_free()
		queue_free()
	pass
	
func _shattered_aggro() -> void:
	move_speed = move_speed * 2
	get_child(0).set_color("BLACK")
	shattered = true
	pass
	
func _shattered_calm() -> void:
	move_speed = move_speed * .5
	_change_color(e_color,e_color)
	shattered = false
	pass
