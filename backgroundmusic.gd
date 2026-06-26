extends AudioStreamPlayer

@onready var sound_effect = preload("res://rideofthevalkyries.mp3")
@onready var plane = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.stream = sound_effect
	self.playing = true
	print(str(self.playing))


# Called every frame. 'delta' is the elapsed time since the previous frame.
