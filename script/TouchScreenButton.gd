extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("touch"):
		Gamehandler.puntos += 20
		Gamehandler.update_puntos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
