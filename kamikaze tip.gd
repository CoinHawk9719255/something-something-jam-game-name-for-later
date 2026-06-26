extends Label
@onready var plane = get_parent()
#var can_kamikaze = plane.can_kamikaze

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hint()


func hint():
	if plane.can_kamikaze == true:
		visible = true
