extends RigidBody2D

func _ready():
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:

	print("touched: " + body.name)

	if body is RigidBody3D:

		pass
