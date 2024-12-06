extends Camera2D

var zoom_current : float = 1 
var zoom_target : float = 1 
var zoom_increment = .8


func _ready() -> void:
	pass

func _process(delta) -> void:
	zoom_current = lerp(zoom_current, zoom_target, zoom_increment * delta)
	set_zoom(Vector2(zoom_current, zoom_current))
pass

func _set_zoom_target(target : float, percent : float) -> void:
	zoom_target = target
	zoom_increment =  percent
pass
