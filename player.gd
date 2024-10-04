extends Polygon2D
var move_speed = 400
var angular_speed = PI
var p_bullet = preload("res://bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("ui_move_left"):
		direction = -1
	if Input.is_action_pressed("ui_move_right"):
		direction = 1

	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_move_up"):
		velocity = Vector2.RIGHT.rotated(rotation) * move_speed
	if Input.is_action_pressed("ui_move_down"):
		velocity = Vector2.LEFT.rotated(rotation) * move_speed
	
	position += velocity * delta
	
	if Input.is_action_pressed("ui_shoot") && get_node("Shooting Timer").is_stopped():
		var bullet_instance = p_bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.set_z_as_relative(true)
		bullet_instance.set_z_index(3)
		bullet_instance.global_position = get_node("Marker2D").global_position
		get_node("Shooting Timer").start()
		
	#Adapted code from the godot docs, will fine tune later
	pass
