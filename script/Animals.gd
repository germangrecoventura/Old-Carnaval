extends Node

func _ready():
	for cow in get_tree().get_nodes_in_group("cow"):
		cow.get_node("Body").set_material(load("res://shader/Animal.tres"))
		
