extends TouchScreenButton
onready var touch = $"../../Virtual joystick"
onready var light = $"../../Ufo/Ship/Light"
onready var tween = $"../../Tween"
onready var areaLight =$"../../Ufo/Ship/Light/Area2D/CollisionShape2D"
onready var glitch = $"../../Glitch"
onready var ufo = $"../../Ufo"



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
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,458.895),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,1.637),2.0)
	tween.start()
	
func light_glitch() -> void:
	#areaLight.disabled = true
	#tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,210.657),2.0)
	#tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0.516),2.0)
	#tween.start()
	pass
func _on_TimerAbduct_timeout():
	$"../../Ufo/Ship/Light/TimerReturnLight".start()
	tween.interpolate_property(light,"position",light.position,Vector2(light.position_actual.x,light.position_actual.y),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0),2.0)
	tween.start()
	#$"../../UfoResponsive/Ufo/Light/TimerReturnLight".start()
	#tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,-42.857),2.0)
	#tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,-0),2.0)
	#tween.start()
	pass

func _on_TouchAbduction_pressed():
	hide_ui()
	$"../../Ufo/Ship/Light/TimerAbduct".start()
	$"../../TimerTimeGame".paused = true
	areaLight.disabled = false
	#var random = RandomNumberGenerator.new()
	#random.randomize()
	#if (random.randfn() >= 0.5):
	light_down()
	#else:
	#	light_glitch()
	#	glitch.set_material(load("res://shader/Glitch.tres"))


func _on_TimerReturnLight_timeout():
	glitch.set_material(null)
	show_ui()
	areaLight.disabled = true
	$"../../TimerTimeGame".paused = false
	
