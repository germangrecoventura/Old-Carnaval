extends "res://script/AbstractState.gd"


func update(delta:float):
	if 2+2 == 4:
		emit_signal("finished", "walk")
