extends TouchScreenButton

export (int) var points_to_add

func _physics_process(delta):
	if Input.is_action_just_pressed("touchLeft"):
		#$"../..".points += points_to_add
		if $"../../Ufo".position.x -30 > 418:
			$"../../Ufo".position.x -= 30	
