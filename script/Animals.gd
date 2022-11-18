extends Node

func _ready():
	var random = RandomNumberGenerator.new()
	for animal in get_children():
		random.randomize()
		animal.position.x = random.randf_range(304,1150)

	for cow in get_tree().get_nodes_in_group("cow"):
		cow.get_node("Body").set_material(load("res://shader/Animal.tres"))


func _on_StaticFloor_body_entered(body):
	body.sound_jump()
	body.apply_impulse(Vector2.ZERO,Vector2(0,body.impulse))
