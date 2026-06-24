extends RigidBody2D

@onready var projectile := preload("res://bullet.tscn")
@onready var wall = get_node("../lowerboundcollisionwall/lower_bound")
@onready var fire_rate = 0.05
@onready var pressedButton = false
@onready var speed = 10.0
@onready var roll = false
@onready var time_since_shot = fire_rate
@export var ammo = 3
@onready var wepFuel = 300
@onready var can_kamikaze = false
@onready var canControl_plane = true
@export var kamikazing = false
@export var player_plane_y = 0
@export var player_plane_x = 0
@onready var health = 100
@export var target: Node2D
@onready var my_position = 631
func _physics_process(delta):
	#if health <= 0:
	#	get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")
	my_position = global_position.x
	player_plane_x = global_position.x
	player_plane_y = global_position.y
	kamikaze()
	time_since_shot += delta
	shoot_bullet()
	if canControl_plane == true:
		barrel_roll()
		wep()
		var input = Input.get_axis("up", "down")
		if input != 0.0:
			apply_central_impulse(Vector2(0, input) * speed)
func wep():
	if kamikazing == false:
		
			if Input.is_action_pressed("space"):
				if my_position < 631:
					if wepFuel > 0:
						#print("wepping")
						apply_central_impulse(Vector2(1, 0))
						wepFuel -= 1
						#print("wep fuel currentdown" + str(wepFuel))
					else:
						pass
			else:
		
				if wepFuel == 300:
					pass
				elif wepFuel > 300:
					wepFuel = 300
				elif wepFuel < 0:
					wepFuel = 0
				else:
					#await get_tree().create_timer(8).timeout
					
					#print("unwepping")
					wepFuel +=0.1
		
			#print("wep fuel currentup" + str(wepFuel))
#KAMIKAZE!!!!!!! FOR THE EMPEROR AND WhATNOT
func kamikaze():
	
	if ammo <= 0:
		can_kamikaze = true
	if can_kamikaze == true:
		if Input.is_action_just_pressed("kamikaze"):
			kamikazing = true
			speed = 5
	if kamikazing == true:
		await get_tree().create_timer(1.5).timeout
		apply_central_impulse(Vector2(100, 0))
	
func _ready():
	$roll_cooldown.start()
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(body: Node2D) -> void:	
	if body.name == "lower_bound":
		print("touched: " + body.name)
		get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")
	if body.name == "right_bound":
		print("touched: " + body.name)
		get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")
	if body.name == "enemy_bullet_projectile":
		print("YOU GOT A HOLE IN YOUR LEFT WING!")
		health -= 5
	if body.name == "left_bound":
		print("touched: "+body.name)
		get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")
		
func barrel_roll():
	if roll == true:
		if Input.is_key_pressed(KEY_Q):
			roll = false
			apply_central_impulse(Vector2(0, 200))
			$roll_cooldown.start()
			await get_tree().create_timer(1.25).timeout
			apply_central_impulse(Vector2(0, -300))
		elif Input.is_key_pressed(KEY_E):
			roll = false
			apply_central_impulse(Vector2(0, -200))
			$roll_cooldown.start()
			await get_tree().create_timer(1.25).timeout
			apply_central_impulse(Vector2(0, 280))

func _on_roll_cooldown_timeout() -> void:
	roll = true

#shooting shooting pew pew
func shoot_bullet():
	
	
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		if time_since_shot >= fire_rate &&  ammo > 0:
			time_since_shot = 0.0
			ammo -= 1
			createBullet()
			
	#pressedButton = true
	#elif not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	#pressedButton = false
		

func createBullet():
	var newBullet = projectile.instantiate()  
	get_tree().current_scene.add_child(newBullet)
	newBullet.global_position = global_position  
