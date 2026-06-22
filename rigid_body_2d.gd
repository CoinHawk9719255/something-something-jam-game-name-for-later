extends RigidBody2D

@onready var target = get_node("../lowerboundcollisionwall/lower_bound") 
var speed = 10.0
func _physics_process(delta):
	var input = Input.get_axis("up", "down")
	if input != 0.0:
		apply_central_impulse(Vector2(0,input) * speed)

func _ready():
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "lower_bound":
		print("touched: " + body.name)
		
		get_tree().change_scene_to_file("res://game_over_man_its_game_over.tscn")
