extends RigidBody2D
@onready var projectile := preload("res://enemy_bullet.tscn")
@onready var speed = 15
@onready var random_speed = 0
@onready var time_since_last_move = 0
@onready var moveThingyMagigy = 3
@onready var target: Node2D = null
@onready var view_distance = 3000
@onready var fov_degrees = 13
@onready var time_since_shot = 0
@onready var fire_rate = 0.03
@onready var enemy_plane_y = 0
@onready var enemy_plane_x = 0
@onready var plane = get_node("../../plane/plane")
@onready var player_plane_x = plane.player_plane_x
@onready var player_plane_y = plane.player_plane_y
@onready var feeling_shot = false
@onready var enemy_ammo = 250
@onready var reloading = true
@onready var hitByKamikaze = false
@onready var fuel = 30000

func _ready() -> void:
	$move_cooldown.start()
	#await get_trwee().create_timer(0.15).timeout
	random_speed = randi_range(-600, 600)
	apply_central_impulse(Vector2(0, random_speed)*3)


func _process(delta: float) -> void:

	
	dodgeKamikaze()
	reload()
	time_since_shot += delta
	enemy_plane_x = global_position.x
	enemy_plane_y = global_position.y
	player_plane_y = plane.player_plane_y
	time_since_last_move += delta
	fight_against()
	calculateUpDown()
	target = get_tree().get_first_node_in_group("player planes")
	if can_see_target():
		shoot_bullet()
	else:
		pass
func can_see_target() -> bool:
	target = get_tree().get_first_node_in_group("player planes")
	if not target:
		return false
	
	var to_target = target.global_position - global_position
	

	if to_target.length() > view_distance:
		return false
	

	var facing_dir = Vector2.LEFT.rotated(rotation)  
	
	
	var angle_to_target = facing_dir.angle_to(to_target)
	if abs(angle_to_target) > deg_to_rad(fov_degrees / 2.0):
		return false
	
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	query.collision_mask = collision_mask
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result.is_empty():
		return false
	return result.collider == target

func dodgeKamikaze(): 
	if plane.kamikazing == true:
		await get_tree().create_timer(1.25).timeout
		print('dodge')
		apply_central_impulse(Vector2(0,randi_range(-200, 200)))

func calculateUpDown():
	if time_since_last_move >= moveThingyMagigy:
		time_since_last_move = 0
		
		if player_plane_y < enemy_plane_y:
			random_speed = randi_range(-100, -400)
		
		elif player_plane_y > enemy_plane_y:
			random_speed = randi_range(100, 400)
			
		else:
			random_speed = randi_range(-300, 300)
		apply_central_impulse(Vector2(0, random_speed)*3)
	
	if feeling_shot == true:
		#print("I felt shot")
		feeling_shot = false
		#print("moving also feeling shot is "+ str(feeling_shot))
		apply_central_impulse(Vector2(0,randi_range(-300,300)))
func _move_cooldown_timeout() -> void:
	moveThingyMagigy = randi_range(1,5)
	$move_cooldown.start()

func shoot_bullet():
	if time_since_shot >= fire_rate:
		time_since_shot = 0.0
		if enemy_ammo > 0:
			enemy_ammo -= 1
			
			createBullet()
		else:
			reloading = true

func createBullet():
	
	var newBullet = projectile.instantiate()  
	get_tree().current_scene.add_child(newBullet)
	newBullet.global_position = global_position  


func _on_body_entered(body: Node2D) -> void:
	if body.name == "plane":
		hitByKamikaze = true
	if body.name == "right_bound":
		if hitByKamikaze == true:
			get_tree().change_scene_to_file("res://kamikaze_win.tscn")
		else :
			get_tree().change_scene_to_file("res://win.tscn")
	if body.name == "bullet_projectile":
		feeling_shot = true
func fight_against():
	if fuel > 0:
	
		print(fuel)
		if enemy_plane_x > 2110:
			apply_central_impulse(Vector2(-2,0))
			fuel -=5
			print("pushing")
		if enemy_plane_x < 2120:
			apply_central_force(Vector2(10,0))
			fuel -=10
			print("too far")

func reload():
	if reloading == true:
		reloading = false
		await get_tree().create_timer(3).timeout
		enemy_ammo = 150
