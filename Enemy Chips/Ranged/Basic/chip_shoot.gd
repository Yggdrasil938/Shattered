extends "res://Enemy Chips/Shared/chip_parent.gd"
@onready var bullet_spawn : Node = get_child(4)
var e_bullet = preload("res://Enemy Chips/Ranged/Shared/chip_bullet.tscn") 
@onready var current_level :  Node = get_tree().get_first_node_in_group("levels")
var random = RandomNumberGenerator.new()
@onready var timer = get_child(3)
var waiting_to_shoot = false
@onready var combat_layer:  Node = get_tree().get_first_node_in_group("combat layer")


# Called when the node enters the scene tree for the first ti me.
func _ready() -> void:
	random.randomize()
	move_speed = 100
	timer.start(randf_range(0,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		if get_child(5).is_stopped() && waiting_to_shoot  == false:
			get_child(5).start(2)
			timer.start(2.1)
			waiting_to_shoot  = true
			
	if timer.is_stopped() != true && get_child(5).is_stopped() && waiting_to_shoot:
		
		var bullet_instance = e_bullet.instantiate()
		combat_layer.add_child(bullet_instance)
		bullet_instance._change_color(current_level.level_pane_set[e_color], e_color)
		if shattered ==  true:
				bullet_instance._shattered_aggro() 
		bullet_instance.global_position = bullet_spawn.global_position
		waiting_to_shoot  = false
		timer.start(randf_range(3,6))
		
	if waiting_to_shoot != true:
		global_position += direction * move_speed * delta
	pass
