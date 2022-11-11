extends Sprite
onready var tween = $"../../Tween"
onready var abduct = true
onready var touch = $"../../Virtual joystick"
onready var touchAbduction = $"../../ControlTouchAbduction/TouchAbduction"
onready var glitch = $"../../Glitch"
onready var timerTimeGame =$"../../TimerTimeGame"
onready var level =$"../.."
var position_actual
onready var glitch_enabled = false
onready var ufo = get_parent()

func add_position(value):
	position_actual = value

func activate_glitch() -> void:
	glitch_enabled = true


func _ready():
	$Area2D/CollisionShape2D.disabled = true


func hide_ui():
	if (touch.visible):
		touch.set_process_input(false)
		touch.visible = false
	if (touchAbduction.visible):
		touchAbduction.set_process_input(false)
		touchAbduction.visible = false
	
	
func abduct(body) -> void:
	var name = String(body.name)
	if glitch_enabled:
		body.abduct_glitched = true
		glitch.set_material(load("res://shader/Glitch.tres"))
		yield(get_tree().create_timer($TimerReturnLight.wait_time), "timeout")
		$Area2D/CollisionShape2D.disabled = true
		$TimerReturnLight.start()
		yield(get_tree().create_timer($TimerReturnLight.wait_time), "timeout")
		self.texture= load("res://assets/entity/light.png")
		abduct = true
		glitch_enabled = false
		ufo.statusUfo += 1
	else:
		body.abduct = true
		yield(get_tree().create_timer($TimerReturnLight.wait_time), "timeout")
		$TimerReturnLight.start()
		yield(get_tree().create_timer(1.5), "timeout")
		abduct = true
		level.add_animal(name)
		if level.is_winner():
			timerTimeGame.stop()
			level._on_TimerTimeGame_timeout()
			hide_ui()
		else:
			self.texture= load("res://assets/entity/light.png")
#
func _on_Area2D_body_entered(body):
	if abduct:
		abduct = false
		if !get_tree().get_nodes_in_group("cow").has(body):
			self.texture= load("res://assets/entity/lightFail.png")
			abduct(body)
		else:
			self.texture= load("res://assets//entity/lightWinner.png")
			abduct(body)
		






