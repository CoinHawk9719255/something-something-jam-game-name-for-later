extends RigidBody2D
@export var bullet_projectile: PackedScene = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	linear_velocity = Vector2(100, 0)  # set initial velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func apply_force_example():
	apply_central_impulse(Vector2(0, -300))  # e.g. a jump/punch
