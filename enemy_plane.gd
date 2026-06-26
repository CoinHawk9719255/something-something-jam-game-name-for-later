extends RigidBody2D
@onready var projectile := preload("res://enemy_bullet.tscn")
@onready var speed = 15
@onready var random_speed = 0
@onready var time_since_last_move = 0
@onready var moveThingyMagigy = 3
@onready var target: Node2D = null
@onready var view_distance = 3000
@onready var fov_degrees = 15 
@onready var time_since_shot = 0
@onready var fire_rate = 0.03
@onready var enemy_plane_y = 0
@onready var enemy_plane_x = 0
@onready var mrrightbound = get_node("res://")
@onready var plane = get_node("../../plane/plane")
@onready var player_plane_x = plane.player_plane_x
@onready var player_plane_y = plane.player_plane_y
@onready var feeling_shot = false
@onready var enemy_ammo = 125
@onready var reloading = true
@onready var hitByKamikaze = false
@onready var timeSinceLastMove2 = 0
@onready var kamikaze_dodger_speed = 0
@onready var fuel = 10000
@export var cutscenestart = false
@onready var pending_rotation = 0
@onready var timeDelata = 0.0

func _ready() -> void:

	$move_cooldown.start()
	#await get_trwee().create_timer(0.15).timeout
	random_speed = randi_range(-600, 600)
	apply_central_impulse(Vector2(0, random_speed)*3)

func check_for_cutscene():
	if cutscenestart == true:
		pass

func _process(delta: float) -> void:
	timeDelata += delta
	if enemy_plane_x >= 2300:
		cutscenestart = true
	dodgeKamikaze()
	reload()
	time_since_shot += delta
	enemy_plane_x = global_position.x
	enemy_plane_y = global_position.y
	player_plane_y = plane.player_plane_y
	time_since_last_move += delta
	timeSinceLastMove2 += delta
	
	fight_against()
	track_player_y()
	calculateUpDown()
	target = get_tree().get_first_node_in_group("player planes")
	if can_see_target():
		shoot_bullet()
	else:
		pass
func process(_delta: float) -> void:
	await get_tree().create_timer(0.25).timeout
	kamikaze_dodger_speed = randi_range(-600, 600)
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if pending_rotation != 0.0:
		state.transform = state.transform.rotated_local(pending_rotation)
		pending_rotation = 0.0
	if pending_rotation == 0 && timeDelata > 2 :
		var howMuchIHaveToRotate = 0
		if global_rotation_degrees != 0.0:
			timeDelata = 0
			howMuchIHaveToRotate = abs(360 - global_rotation_degrees)
			rotate(deg_to_rad(howMuchIHaveToRotate))
 
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

		apply_central_impulse(Vector2(randi_range(-200, 200),kamikaze_dodger_speed))

func track_player_y() -> void:
	#if timeSinceLastMove2 > randi_range(0,5):
		#timeSinceLastMove2 = 0
	if 0 == 0:
		var y_diff = player_plane_y - enemy_plane_y
		var distance = abs(y_diff)

		if distance > 3: 
			var direction = sign(y_diff)
			var force_strength = clamp(distance * 2.5, 50, 500)
			apply_central_force(Vector2(0, direction * force_strength))
		else:
			
			linear_velocity.y = move_toward(linear_velocity.y, 0.0, 50)
				
func calculateUpDown():
	if time_since_last_move >= moveThingyMagigy:
		time_since_last_move = 0
		if player_plane_y < enemy_plane_y:
			random_speed = randi_range(-200, -200)	
		elif player_plane_y > enemy_plane_y:
			random_speed = randi_range(200, 200)
		else:
			random_speed = randi_range(-350, 350)
		apply_central_impulse(Vector2(0, random_speed)*3)
		
	
	if feeling_shot == true:
		feeling_shot = false
		var forwardBackwards = 0
		#if enemy_plane_x < 2300:
		forwardBackwards = randi_range(-150,150)
		
		apply_central_impulse(Vector2(forwardBackwards,randi_range(-300,300)))




func shoot_bullet():
	if time_since_shot >= fire_rate:
		time_since_shot = 0.0
		if enemy_ammo > 0:
			enemy_ammo -= 1
			
			createBullet()
		else:
			reloading = true

func createBullet():
	var newBullet = projectile.instantiate() as Node2D
	get_tree().current_scene.add_child(newBullet)
	newBullet.global_position = global_position
	newBullet.rotation = rotation
	var bullet_body = newBullet.get_node("enemy_bullet_projectile") as RigidBody2D
	bullet_body.linear_velocity = Vector2.LEFT.rotated(rotation) * 900



func _on_body_entered(body: Node2D) -> void:
	if body.name == "plane" && plane.kamikazing == true:
		hitByKamikaze = true
	if body.name == "right_bound":
		if hitByKamikaze == true:
			get_tree().change_scene_to_file("res://kamikaze_win.tscn")
		else :
			get_tree().change_scene_to_file("res://win.tscn")
	if body.name == "bullet_projectile":
		feeling_shot = true
		pending_rotation += deg_to_rad(45)
func fight_against():
	if fuel > 0:
		if enemy_plane_x > 2100:
			apply_central_impulse(Vector2(-3.5,0))
			fuel -= 10
	if enemy_plane_x < 2120:
		apply_central_force(Vector2(20,0))

	if fuel <= 0:
		apply_central_impulse(Vector2(0.01,0))
func reload():
	if reloading == true:
		reloading = false
		await get_tree().create_timer(3).timeout
		enemy_ammo = 125


func _on_move_cooldown_timeout() -> void:

	moveThingyMagigy = randi_range(1,5)
	
	$move_cooldown.start()


	
	
