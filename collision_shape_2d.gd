extends RigidBody2D
func _on_body_entered(body: Node) -> void:
	print("right bound touched: " + body.name)
