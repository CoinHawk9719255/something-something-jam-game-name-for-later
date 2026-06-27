extends Label

@onready var TextScene = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if TextScene == 0:
		self.text = "Works best for 2560x1600 monitors\n haven't found how to get it \nto work on others yet"
	if TextScene == 1:
		self.text = "HI"
	if TextScene == 2:
		self.text = "This is a very SERIOUS game"
	if TextScene == 3:
		self.text = "Basically"
	if TextScene == 4:
		self.text = "Theres the Blue Baron... \nHe must fight the Red Baron's air force.  \n... and thusly, he does ..."
	if TextScene == 5:
		self.text = "He must now face the RED BARON Himself!"
	if TextScene == 6:
		self.text = "Heres the controls"
	if TextScene == 7:
		self.text = "'Q' and 'E' to roll left and right\n'W' to go up 'S' to go down\n'Space' to go forward until \nyou hit an invisble wall \n'Left Mouse Click' to shoot "
	if TextScene == 8:
		self.text = "Knock him out of the scene"
	if TextScene == 9:
		self.text = "And dont get yourselft knocked\n of the scene"
	if TextScene == 10:
		self.text = "Good Luck"
	if TextScene == 11:
		self.text = "Enjoy me and my partner's\nfirst ever attempt at godot"
	if TextScene == 12:
		get_tree().change_scene_to_file("res://1 i guess.tscn")
	TextScene += 1
