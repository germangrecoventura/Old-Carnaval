extends TouchScreenButton
onready var touch = $"../../Virtual joystick"
onready var light = $"../../Ufo/Ship/Light"
onready var tween = $"../../Tween"
onready var areaLight =$"../../Ufo/Ship/Light/Area2D/CollisionShape2D"
onready var glitch = $"../../Glitch"
onready var ufo = $"../../Ufo"
onready var timerLight = $"../../Ufo/Ship/Light/TimerReturnLight"
onready var try = 2
onready var glitches = 0

func hide_ui():
	touch._reset()
	touch.set_process_input(false)
	self.set_process_input(false)
	touch.visible = false
	self.visible = false


func show_ui():
	touch.set_process_input(true)
	self.set_process_input(true)
	touch.visible = true
	self.visible = true


func light_down() -> void:
	light.add_position(light.position)
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,458.895),timerLight.wait_time)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,1.637),timerLight.wait_time)
	tween.start()
	
func light_glitch() -> void:
	if glitches % 2 == 1:
		light.add_position(light.position)
		tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,131.672),timerLight.wait_time)
		tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0.317),timerLight.wait_time)
		tween.start()
		glitch.set_material(load("res://shader/Glitch.tres"))
		yield(get_tree().create_timer(timerLight.wait_time), "timeout")
		glitch.set_material(null)
		glitches += 1
	else:
		light.activate_glitch()
		light_down()
		glitches += 1
		
func _on_TimerAbduct_timeout():
	$"../../Ufo/Ship/Light/TimerReturnLight".start()
	tween.interpolate_property(light,"position",light.position,Vector2(light.position_actual.x,light.position_actual.y),timerLight.wait_time)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0),timerLight.wait_time)
	tween.start()

func _on_TouchAbduction_pressed():
	hide_ui()
	$"../../Ufo/Ship/Light/TimerAbduct".start()
	$"../../TimerTimeGame".paused = true
	$"../../AnimationPlayer".stop(false)
	areaLight.disabled = false
	try += 1
	if (try % 3 == 0):
		try += 1
		light_glitch()
	else:
		try += 1
		light_down()


func _on_TimerReturnLight_timeout():
	glitch.set_material(null)
	show_ui()
	areaLight.disabled = true
	$"../../TimerTimeGame".paused = false
	$"../../AnimationPlayer".play()
	
