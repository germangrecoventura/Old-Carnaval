extends Node2D

var selected:bool = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("touch"):
		Gamehandler.puntos += 20
		Gamehandler.update_puntos()
		selected = true


func _physics_process(delta):
	if selected:
		
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
