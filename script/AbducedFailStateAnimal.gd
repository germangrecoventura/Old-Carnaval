extends "res://script/AbstractState.gd"

onready var tween = $"../../Tween"

func enter():
	tween.interpolate_property(parent,"position",parent.position,Vector2(parent.position.x,393),0.5)
	tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	tween.interpolate_property(parent,"position",parent.position,Vector2(parent.position.x,513),0.5)
	tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	parent.abduct_glitched = false
	emit_signal("finished", "walk")


