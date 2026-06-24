extends Label

@onready var plane = get_node("../../plane/plane")

func _process(delta: float) -> void:
	self.text = "Ammo "+str(plane.ammo)+"\n"+"Fuel "+str(int(plane.wepFuel))
	
