extends "res://script/states/AbstractState.gd"

onready var joystickLeft : VirtualJoystick = $"../../../Virtual joystick"
onready var animationUfo = $"../../../UfoAnimation"

func enter():
	animationUfo.play("ufo_glitch")

func update(delta:float):
	if parent.statusUfo % 4 == 0:
		animationUfo.stop()
		emit_signal("finished", "normal")
	parent.position.x += joystickLeft.get_output().y * parent.speed * delta
	var move := Vector2.ZERO
	move.x = Input.get_axis("ui_left", "ui_right")
	parent.position += move * parent.speed * delta
	
