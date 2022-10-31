extends Node

signal e

export (String) var level
export (int) var dificulty
export (PackedScene) var retry

func _on_Retry_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene(retry)

func update_maximus_points():
	var point = Gamehandler.leardboard[level]
	$RecordActual/Record.text = String(point)

func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene("res://scenes/Menu.tscn")
