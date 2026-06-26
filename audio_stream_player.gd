extends AudioStreamPlayer


var sound_effect = preload("res://banzai.mp3")
var kamikazeability = true;
@onready var plane = get_parent()

func _process(delta):
	var kamikazing = plane.kamikazing
	if kamikazing && kamikazeability == true:
		kamikazeability = false;
		self.playing = true;
		pass
