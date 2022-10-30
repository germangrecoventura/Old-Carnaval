extends Node

func _ready():
	for child in get_children():
		if child.name == "Cow":
			$Cow.get_node("Body").set_material(load("res://shader/Animal.tres"))
