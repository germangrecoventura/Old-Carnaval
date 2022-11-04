extends "res://script/AbstractState.gd"

onready var joystickLeft : VirtualJoystick = $"../../../Virtual joystick"

func enter():
	print("Moviendo")

func handle_input(event:InputEvent):
	if joystickLeft and !joystickLeft.is_pressed():
		emit_signal("finished", "idle")


func update(delta:float):
	parent.position.x += joystickLeft.get_output().y * parent.speed * delta
	var move := Vector2.ZERO
	move.x = Input.get_axis("ui_left", "ui_right")
	parent.position += move * parent.speed * delta
	
