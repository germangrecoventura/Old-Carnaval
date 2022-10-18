extends Sprite
onready var tween = $"../../Tween"
onready var abduct = true
onready var touchLeft = $"../../UI/TouchLeft"
onready var touchRight = $"../../UI/TouchRight"
onready var touchAbduction = $"../../UI/TouchAbduction"

func hide_ui():
	touchLeft.visible = false
	touchRight.visible = false
	self.visible = false


func light_up() -> void:
	tween.interpolate_property(self,"position",self.position,Vector2(self.position.x,67.094),2.0)
	tween.interpolate_property(self,"scale",self.scale,Vector2(self.scale.x,-0.001),2.0)
	tween.start()
	
func abduct(body) -> void:
	var name = body.name
	print(body) # Replace with function body.
	get_parent().get_parent()._add_points(1)
	var move_tween:SceneTreeTween = get_tree().create_tween()
	move_tween.tween_property(body,"global_position",Vector2(body.global_position.x,211),2.0)
	yield(get_tree().create_timer(2), "timeout")
	body.queue_free()
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
		






