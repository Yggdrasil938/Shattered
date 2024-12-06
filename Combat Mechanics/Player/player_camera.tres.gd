extends Camera2D

var zoom_current : int = 1 
var zoom_target : int = 1 
var zoom_increment = .8


func _ready() -> void:
	pass

func _process(delta) -> void:
	zoom_current = lerp(zoom_current, zoom_target, zoom_increment * delta)
	set_zoom(Vector2(zoom_current, zoom_current))
pass

func _set_zoom_target(target : int) -> void:
	zoom_target = target
pass
