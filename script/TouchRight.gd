extends TouchScreenButton

func _on_TouchRight_pressed():
	if $"../../Ufo".position.x +30 < 1335:
			$"../../Ufo".position.x += 30	
