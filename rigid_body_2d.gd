extends RigidBody2D

var speed = 10.0

func _physics_process(delta):
	var input = Input.get_axis("up", "down")
	if input != 0.0:
		apply_central_impulse(Vector2(0,input) * speed)
