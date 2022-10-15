extends TouchScreenButton
onready var touchLeft = $"../TouchLeft"
onready var touchRight = $"../TouchRight"


func hide_ui():
	touchLeft.visible = false
	touchRight.visible = false
	self.visible = false


func show_ui():
	touchLeft.visible = true
	touchRight.visible = true
	self.visible = true


func _on_TimerAbduct_timeout():
	$"../../Light/TimerReturnLight".start()
	$"../../AnimationPlayer".play("light_back")
	

func _on_TouchAbduction_pressed():
	hide_ui()
	$"../../AnimationPlayer".play("light")
	$"../../Light/TimerAbduct".start()


func _on_TimerReturnLight_timeout():
	show_ui()
	$"../../Light/Area2D".set_process(true)
	
