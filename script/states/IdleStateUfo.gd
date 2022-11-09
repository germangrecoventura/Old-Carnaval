extends "res://script/states/AbstractState.gd"

onready var joystickLeft : VirtualJoystick= $"../../../Virtual joystick"
onready var animationUfo = $"../../../UfoAnimation"

func enter():
	print("Quieto")

func handle_input(event:InputEvent):
	if joystickLeft and joystickLeft.is_pressed():
		emit_signal("finished", "walk")


func update(delta:float):
	if parent.statusUfo % 3 == 0:
		animationUfo.play("ufo_normal")
	if parent.statusUfo % 3 == 1:
		animationUfo.play("ufo_medio")
	if parent.statusUfo % 3 == 2:
		animationUfo.play("ufo_normal")
