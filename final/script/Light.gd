extends Sprite
onready var tween = $"../../Tween"
onready var abduct = true
onready var touch = $"../../UI/Control2/Virtual joystick"
onready var touchAbduction = $"../../UI/Control3/TouchAbduction"
onready var glitch = $"../../Control/Glitch"

func hide_ui():
	touch.set_process_input(false)
	touchAbduction.set_process_input(false)
	touch.visible = false
	touch.visible = false


func light_up() -> void:
	tween.interpolate_property(self,"position",self.position,Vector2(self.position.x,50),2.0)
	tween.interpolate_property(self,"scale",self.scale,Vector2(self.scale.x,-0.001),2.0)
	tween.start()
	

func no_abduct(body):
	var random = RandomNumberGenerator.new()
	random.randomize()
	if (random.randfn() < 0.5):
		tween.interpolate_property(body,"position",body.position,Vector2(body.position.x,495),1.0)
		tween.start()
		yield(get_tree().create_timer(1), "timeout")
		tween.interpolate_property(body,"position",body.position,Vector2(body.position.x,645),1.0)
		tween.start()
		yield(get_tree().create_timer(2), "timeout")
		self.texture= load("res://assets/entity/luz.png")
		abduct = true
	else:
		var move_tween:SceneTreeTween = get_tree().create_tween()
		move_tween.tween_property(body,"global_position",Vector2(body.global_position.x,280),2.0)
		yield(get_tree().create_timer(2), "timeout")
		body.queue_free()
		if name != "Cow":
			glitch.set_material(load("res://shader/Glitch.tres"))
			yield(get_tree().create_timer(1), "timeout")
			glitch.set_material(null)		
		$TimerReturnLight.start()
		light_up()
		yield(get_tree().create_timer(2), "timeout")
		abduct = true
		if name == "Cow":
			$"../..".add_animal(name)
			$"../../TimerTimeGame".stop()
			hide_ui()
			get_parent().get_parent()._on_TimerTimeGame_timeout()
		else:
			self.texture= load("res://assets/entity/luz.png")

	
func abduct(body) -> void:
	var name = body.name
	print(body) # Replace with function body.
	get_parent().get_parent()._add_points(1)
	no_abduct(body)
#	var move_tween:SceneTreeTween = get_tree().create_tween()
#	move_tween.tween_property(body,"global_position",Vector2(body.global_position.x,280),2.0)
#	yield(get_tree().create_timer(2), "timeout")
#	body.queue_free()
#	if name != "Cow":
#		glitch.set_material(load("res://shader/Glitch.tres"))
#		yield(get_tree().create_timer(1), "timeout")
#		glitch.set_material(null)		
#	$TimerReturnLight.start()
#	light_up()
#	yield(get_tree().create_timer(2), "timeout")
#	abduct = true
#	if name == "Cow":
#		$"../..".add_animal(name)
#		$"../../TimerTimeGame".stop()
#		hide_ui()
#		get_parent().get_parent()._on_TimerTimeGame_timeout()
#	else:
#		self.texture= load("res://assets/entity/luz.png")

func _on_Area2D_body_entered(body):
	if abduct:
		abduct = false
		var name = body.name
		if name != "Cow":
			self.texture= load("res://assets/entity/MalEfecto.png")
			abduct(body)
		else:
			self.texture= load("res://assets//entity/Luz3.png")
			abduct(body)
		






