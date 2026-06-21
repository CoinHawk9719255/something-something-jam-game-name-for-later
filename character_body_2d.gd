extends CharacterBody2D
#HAHA LARPSAN INGSAN'S A LARPER
func larpsan(from: float, to: float, weight: float) -> float:
	return lerp_angle(from, to, weight)
	
var speed = 400
var rotation_speed = 2
#move and look at mouse slowly i mean pretty self explanatory
#ven 'I' who never coded in godot till this day made this
#work with only a lilttle struggle and pain and suffering
#and a complete lack of physics and degree radian nonsense
#that i wouldve known if i actually listened in physics class
func get_input():
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	rotation = larpsan(rotation, (get_global_mouse_position()-global_position).angle()+deg_to_rad(0), rotation_speed*delta)
	get_input()
	move_and_slide()
