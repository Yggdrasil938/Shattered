extends CanvasLayer
@onready var player = preload("res://player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = player.instantiate()
	add_child(player_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
