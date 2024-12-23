extends CanvasLayer
## ***CHIP SPAWNER SCRIPT***
## Only serves to spawn the player upon layer creation, 
## all other nodes are staticly built into the scene.



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = GlobalConstants.PLAYER.instantiate()
	add_child(player_instance) # Creates player and adds them to node tree.
