extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("left-touch"):
		get_tree().get_nodes_in_group("main")[0].quitar_vida()
	#	get_tree().get_nodes_in_group("main")[0].agregar_vida()
		#$"../ObjetoDrag".queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
