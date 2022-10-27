extends Sprite

onready var joystickLeft : VirtualJoystick = $"../UI/Control2/Virtual joystick"

export var speed : float = 400
func _process(delta: float) -> void:
#	# Movement using the joystick output:
	if joystickLeft and joystickLeft.is_pressed():
		position.x += joystickLeft.get_output().y * speed * delta
	
	# Movement using Input functions:
	var move := Vector2.ZERO
	move.x = Input.get_axis("ui_left", "ui_right")
	#move.y = Input.get_axis("ui_up", "ui_down")
	position += move * speed * delta
