extends TouchScreenButton
#onready var touchLeft = $"../../Control2/TouchLeft"
#onready var touchRight = $"../../Control2/TouchRight"
onready var touch = $"../../Control2/Virtual joystick"
onready var light = $"../../../Ufo/Light"
onready var tween = $"../../../Tween"
onready var areaLight = $"../../../Ufo/Light/Area2D/CollisionShape2D"
onready var glitch = $"../../../Control/Glitch"


func hide_ui():
	$"../../Control2/Virtual joystick"._reset()
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
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,394.286),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,1.526),2.0)
	tween.start()
	
func light_glitch() -> void:
	areaLight.disabled = true
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,210.657),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0.516),2.0)
	tween.start()

func _on_TimerAbduct_timeout():
	$"../../../Ufo/Light/TimerReturnLight".start()
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,-42.857),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,-0),2.0)
	tween.start()
	

func _on_TouchAbduction_pressed():
	hide_ui()
	$"../../../Ufo/Light/TimerAbduct".start()
	$"../../../TimerTimeGame".set_paused(true)
	areaLight.disabled = false
	var random = RandomNumberGenerator.new()
	random.randomize()
	if (random.randfn() >= 0.5):
		light_down()
	else:
		light_glitch()
		glitch.set_material(load("res://shader/Glitch.tres"))


func _on_TimerReturnLight_timeout():
	glitch.set_material(null)
	show_ui()
	$"../../../TimerTimeGame".set_paused(false)
	areaLight.disabled = true
	
