extends "res://script/TouchAbduction.gd"

func _process(delta):
	if Input.is_action_just_pressed("abduction") && self.visible == true:
		_abduced()

func _on_TouchAbduction_pressed():
	animation_tries()
	_abduced()
	
func _on_TimerReturnLight_timeout():
	glitch.set_material(null)
	show_ui()
	areaLight.disabled = true
	$"../../TimerTimeGame".paused = false
	$"../../AnimationPlayer".play()
