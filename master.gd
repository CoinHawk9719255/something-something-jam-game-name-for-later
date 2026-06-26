extends Node

func change_window_size(width: int, height: int):
	DisplayServer.window_set_size(Vector2i(width, height))
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	DisplayServer.window_set_position((screen_size / 2) - (window_size / 2))

func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_BRACKETLEFT):
		change_window_size(1600,900)
		pass
	if Input.is_key_pressed(KEY_BRACKETRIGHT):
		change_window_size(2560,1600)
		pass
	pass
