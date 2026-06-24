extends RigidBody2D
@export var enemy_bullet_projectile: PackedScene = preload("res://enemy_bullet.tscn")
#@export var fromMi = false
#@export var fromEneMi = false
func _ready() -> void:

	apply_central_impulse(Vector2(-940,randi_range(-15,15)))
	await get_tree().create_timer(5.0).timeout
	queue_free()



func _process(_delta: float) -> void:
	pass
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("DIDDY DELETE?")
	queue_free()
	
	
