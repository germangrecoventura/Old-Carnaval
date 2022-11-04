extends "res://script/AbstractState.gd"

onready var joystickLeft : VirtualJoystick= $"../../../Virtual joystick"

func enter():
	print("Quieto")

func handle_input(event:InputEvent):
	if joystickLeft and joystickLeft.is_pressed():
		emit_signal("finished", "walk")
