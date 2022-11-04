extends "res://script/states/AbstractState.gd"

onready var joystickLeft : VirtualJoystick= $"../../../Virtual joystick"

func enter():
	print("Quieto")

func handle_input(event:InputEvent):
	if joystickLeft and joystickLeft.is_pressed():
		emit_signal("finished", "walk")


func update(delta:float):
	if parent.statusUfo % 3 == 0:
		parent.get_node("Ship").texture = load("res://assets/OldCarnaval.png")
	if parent.statusUfo % 3 == 1:
		parent.get_node("Ship").texture = load("res://assets/BackgroundMenu.png")
	if parent.statusUfo % 3 == 2:
		parent.get_node("Ship").texture = load("res://assets/boton_joystick.png")
