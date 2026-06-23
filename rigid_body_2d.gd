extends RigidBody2D

@onready var projectile := preload("res://bullet.tscn")
@onready var target = get_node("../lowerboundcollisionwall/lower_bound") 
@onready var pressedButton = false
#@onready var bullet = get_node("../bullet_projectile").instantiate()
@onready var bullet2new = projectile.instantiate()
var speed = 10.0
var roll = false
func _physics_process(_delta):
	shoot_bullet()
	barrel_roll()
	var input = Input.get_axis("up", "down")
	if input != 0.0:
		apply_central_impulse(Vector2(0,input) * speed)

func _ready():
	
	$roll_cooldown.start()
	body_entered.connect(_on_body_entered)
	var newprojectile = projectile.instantiate()
	add_child(newprojectile)


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
	if not pressedButton and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		createBullet()
		print("Hallo")
		pressedButton = true
		pass
	elif not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pressedButton = false

func createBullet():
	add_child(bullet2new)
	pass
