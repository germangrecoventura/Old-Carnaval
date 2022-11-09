extends "res://script/states/AbstractState.gd"

onready var joystickLeft : VirtualJoystick= $"../../../Virtual joystick"
onready var animationUfo = $"../../../UfoAnimation"

func enter():
	animationUfo.play("ufo_normal")


# FALTA UN ESTADO MAS POR LO QUE NO ES MOD 3 SINO CUATRO
func update(delta:float):
	if parent.statusUfo % 3 == 1:
		animationUfo.stop()
		emit_signal("finished", "damaged")
	if parent.statusUfo % 3 == 2:
		animationUfo.stop()
		emit_signal("finished", "glitch")
	parent.position.x += joystickLeft.get_output().y * parent.speed * delta
	var move := Vector2.ZERO
	move.x = Input.get_axis("ui_left", "ui_right")
	parent.position += move * parent.speed * delta
