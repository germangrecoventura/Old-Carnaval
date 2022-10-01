extends TouchScreenButton

export (int) var points_to_add

func _physics_process(delta):
	if Input.is_action_just_pressed("touch"):
		$"../..".points += points_to_add
