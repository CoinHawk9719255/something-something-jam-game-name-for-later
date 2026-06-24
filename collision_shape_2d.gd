extends RigidBody2D
func _on_body_entered(body: Node) -> void:
	print("left bound touched: " + body.name)
 
