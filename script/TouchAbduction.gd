extends TouchScreenButton
onready var touch = $"../../Virtual joystick"
onready var light = $"../../Ufo/Light"
onready var tween = $"../../Tween"
onready var areaLight =$"../../Ufo/Light/Area2D/CollisionShape2D"
onready var glitch = $"../../Glitch"
onready var ufo = $"../../Ufo"
onready var timerLight = $"../../Ufo/Light/TimerReturnLight"
onready var try = 1
onready var glitches = 1
onready var level = $"../.."
onready var is_abduct = false


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
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,454.623),timerLight.wait_time)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,1.149),timerLight.wait_time)
	tween.start()
	
func light_glitch() -> void:
	if glitches % 2 == 1:
		light.add_position(light.position)
		tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,231.835),timerLight.wait_time)
		tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0.215),timerLight.wait_time)
		tween.start()
		glitch.set_material(load("res://shader/Glitch.tres"))
		#yield(get_tree().create_timer(timerLight.wait_time), "timeout")
		yield(get_tree().create_timer(4.4), "timeout")
		ufo.statusUfo += 1
		glitch.set_material(null)
		glitches += 1
	else:
		light.activate_glitch()
		light_down()
		glitches += 1
		
func _on_TimerAbduct_timeout():
	timerLight.start()
	tween.interpolate_property(light,"position",light.position,Vector2(light.position_actual.x,light.position_actual.y),timerLight.wait_time)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0),timerLight.wait_time)
	tween.start()

func _on_TouchAbduction_pressed():
	hide_ui()
	level._add_points(1)
	$"../../Ufo/Light/TimerAbduct".start()
	$"../../TimerTimeGame".paused = true
	$"../../AnimationPlayer".stop(false)
	areaLight.disabled = false
	ufo.statusUfo += 1
	if (try % 3 == 0):
		try += 1
		light_glitch()
	else:
		try += 1
		light_down()
		
func _process(delta):
	if Input.is_action_just_pressed("abduction") && !is_abduct:
		is_abduct = true
		hide_ui()
		level._add_points(1)
		$"../../Ufo/Light/TimerAbduct".start()
		$"../../TimerTimeGame".paused = true
		$"../../AnimationPlayer".stop(false)
		areaLight.disabled = false
		ufo.statusUfo += 1
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
	is_abduct = false
	
