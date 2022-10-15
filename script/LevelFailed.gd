extends Control

signal e

export (String) var level
export (int) var dificulty

func _on_Retry_pressed():
	pass # Replace with function body.

func update_maximus_points():
	var point = Gamehandler.leardboard.get(level)[dificulty]
	$Panel/RecordActual/Record.text = String(point)

func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene("res://scenes/Menu.tscn")
