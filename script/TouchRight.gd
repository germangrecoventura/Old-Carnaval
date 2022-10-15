extends TouchScreenButton

func _physics_process(delta):
	if Input.is_action_just_pressed("touchRight"):
		#$"../..".points += points_to_add
		if $"../../Ufo".position.x +30 < 818:
			$"../../Ufo".position.x += 30	
