extends Sprite

onready var joystickLeft : VirtualJoystick = $"../../Virtual joystick"
onready var touchAbduction = $"../../ControlTouchAbduction/TouchAbduction"

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

func _on_Area2D_body_entered(body):
	if body.name == "Cloud":
		touchAbduction.visible= false
		touchAbduction.set_process_input(false)


func _on_Area2D_body_exited(body):
	if body.name == "Cloud":
		touchAbduction.visible= true
		touchAbduction.set_process_input(true)
