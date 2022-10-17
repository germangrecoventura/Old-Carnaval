extends TouchScreenButton

func _on_TouchLeft_pressed():
	if $"../../Ufo".position.x -30 > 418:
			$"../../Ufo".position.x -= 30	
