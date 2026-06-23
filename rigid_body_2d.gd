extends RigidBody2D

@onready var target = get_node("../lowerboundcollisionwall/lower_bound") 
var speed = 10.0
var roll = false
func _physics_process(_delta):
	barrel_roll()
	var input = Input.get_axis("up", "down")
	if input != 0.0:
		apply_central_impulse(Vector2(0,input) * speed)

func _ready():
	$roll_cooldown.start()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "lower_bound":
		print("touched: " + body.name)
		
		get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")

func barrel_roll():
	if roll == true:
		if Input.is_key_pressed(KEY_Q):
			roll = false
			apply_central_impulse(Vector2(0,200))
			$roll_cooldown.start()
			await get_tree().create_timer(1.25).timeout
			apply_central_impulse(Vector2(0,-300))
		elif Input.is_key_pressed(KEY_E):
			roll = false
			apply_central_impulse(Vector2(0,-200))
			$roll_cooldown.start()
			await get_tree().create_timer(1.25).timeout
			apply_central_impulse(Vector2(0,280))
		else:
			pass
	


func _on_roll_cooldown_timeout() -> void:
	roll = true


#shooting shooting pew pew
func shoot_bullet():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass

func createBullet():
	
	pass
