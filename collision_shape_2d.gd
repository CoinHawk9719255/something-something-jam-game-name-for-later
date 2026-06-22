extends RigidBody2D
func _on_body_entered(body: Node) -> void:
	print("lower bound touched: " + body.name)
