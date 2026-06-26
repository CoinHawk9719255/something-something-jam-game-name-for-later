extends RigidBody2D
@export var bullet_projectile: PackedScene = preload("res://bullet.tscn")
@export var speed: float = 940


func _ready() -> void:
	#var forward = Vector2.RIGHT.rotated(rotation)
	#var spread = Vector2.UP.rotated(rotation) * randi_range(-15, 15)
	#apply_central_impulse(forward * speed + spread)
	await get_tree().create_timer(5.0).timeout
	queue_free()


func _process(_delta: float) -> void:
	pass
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("DIDDY DELETE?")
	queue_free()
	
	
