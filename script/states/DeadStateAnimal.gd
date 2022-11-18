extends "res://script/states/AbstractState.gd"

onready var particles = $"../../Particles2D"
onready var tween = $"../../Tween"


func enter():
	#tween.interpolate_property(particles,"emitting",false,true,0.5)
	#tween.start()
	#yield(get_tree().create_timer(0.5), "timeout")
	parent.queue_free()
