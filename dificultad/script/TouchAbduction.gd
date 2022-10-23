extends TouchScreenButton
onready var touchLeft = $"../../Control2/TouchLeft"
onready var touchRight = $"../../Control2/TouchRight"
onready var light = $"../../../Ufo/Light"
onready var tween = $"../../../Tween"
onready var areaLight = $"../../../Ufo/Light/Area2D/CollisionShape2D"


func hide_ui():
	touchLeft.visible = false
	touchRight.visible = false
	self.visible = false


func show_ui():
	touchLeft.visible = true
	touchRight.visible = true
	self.visible = true


func light_down() -> void:
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,771.694),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,3.095),2.0)
	tween.start()

func _on_TimerAbduct_timeout():
	$"../../../Ufo/Light/TimerReturnLight".start()
	tween.interpolate_property(light,"position",light.position,Vector2(light.position.x,123.75),2.0)
	tween.interpolate_property(light,"scale",light.scale,Vector2(light.scale.x,0),2.0)
	tween.start()
	

func _on_TouchAbduction_pressed():
	hide_ui()
	$"../../../Ufo/Light/TimerAbduct".start()
	$"../../../TimerTimeGame".set_paused(true)
	areaLight.disabled = false
	light_down()


func _on_TimerReturnLight_timeout():
	show_ui()
	$"../../../TimerTimeGame".set_paused(false)
	areaLight.disabled = true
	
