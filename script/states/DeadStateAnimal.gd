extends "res://script/states/AbstractState.gd"


onready var tween = $"../../Tween"


func enter():
	parent.queue_free()
