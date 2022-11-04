extends "res://script/states/AbstractState.gd"

onready var joystickLeft : VirtualJoystick = $"../../../Virtual joystick"

func enter():
	print("Moviendo")

func handle_input(event:InputEvent):
	if joystickLeft and !joystickLeft.is_pressed():
		emit_signal("finished", "idle")


func update(delta:float):
	if parent.statusUfo % 3 == 0:
		parent.get_node("Ship").texture = load("res://assets/BackgroundMenu.png")
	if parent.statusUfo % 3 == 1:
		parent.get_node("Ship").texture = load("res://assets/BackgroundMenu.png")
	if parent.statusUfo % 3 == 2:
		parent.get_node("Ship").texture = load("res://assets/boton_joystick.png")
	parent.position.x += joystickLeft.get_output().y * parent.speed * delta
	var move := Vector2.ZERO
	move.x = Input.get_axis("ui_left", "ui_right")
	parent.position += move * parent.speed * delta
	
