extends Sprite
onready var tween = $"../../../Tween"
onready var abduct = true
onready var touch = $"../../../Virtual joystick"
onready var touchAbduction = $"../../../ControlTouchAbduction/TouchAbduction"
onready var glitch = $"../../../Glitch"
onready var timerTimeGame =$"../../../TimerTimeGame"
onready var level =$"../../.."
var position_actual
onready var glitch_enabled = false

func add_position(value):
	position_actual = value

func activate_glitch() -> void:
	glitch_enabled = true


func hide_ui():
	if (touch.visible):
		touch.set_process_input(false)
		touch.visible = false
	if (touchAbduction.visible):
		touchAbduction.set_process_input(false)
		touchAbduction.visible = false
	
	
func abduct(body) -> void:
	var name = body.name
	if glitch_enabled:
		tween.interpolate_property(body,"position",body.position,Vector2(body.position.x,393),1.0)
		tween.start()
		yield(get_tree().create_timer(1), "timeout")
		tween.interpolate_property(body,"position",body.position,Vector2(body.position.x,513),1.0)
		tween.start()
		glitch.set_material(load("res://shader/Glitch.tres"))
		yield(get_tree().create_timer(1), "timeout")
		$Area2D/CollisionShape2D.disabled = true
		$TimerReturnLight.start()
		yield(get_tree().create_timer(2), "timeout")
		self.texture= load("res://assets/entity/luz.png")
		abduct = true
		glitch_enabled = false
	else:
		var move_tween:SceneTreeTween = get_tree().create_tween()
		move_tween.tween_property(body,"global_position",Vector2(body.global_position.x,280),2.0)
		yield(get_tree().create_timer(2), "timeout")
		body.queue_free()
		$TimerReturnLight.start()
		yield(get_tree().create_timer(2), "timeout")
		abduct = true
		if name == "Cow":
			level.add_animal(name)
			timerTimeGame.stop()
			hide_ui()
			level._on_TimerTimeGame_timeout()
		else:
			self.texture= load("res://assets/entity/light.png")
#
func _on_Area2D_body_entered(body):
	if abduct:
		abduct = false
		level._add_points(1)
		var name = body.name
		if name != "Cow":
			self.texture= load("res://assets/entity/lightFail.png")
			abduct(body)
		else:
			self.texture= load("res://assets//entity/lightWinner.png")
			abduct(body)
		






