extends AudioStreamPlayer

# Assign the audio stream (can also be done in the Inspector)
var sound_effect = preload("res://banzai.mp3")
var kamikazeability = true;
@onready var plane = get_parent()

func _process(delta):
	print(self.playing)
	var kamikazing = plane.kamikazing
	if kamikazing && kamikazeability == true:
		kamikazeability = false;
		self.playing = true;
		print("PLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\nPLAYING BITCH\n")
		pass
# Ensure you have an AudioStreamPlayer node named "AudioStreamPlayer" in your scene
