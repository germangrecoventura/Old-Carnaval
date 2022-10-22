extends Node

signal e

export (String) var level
export (int) var dificulty
var retry:String

func _on_Retry_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(retry)
	self.queue_free()

func update_maximus_points():
	var point = Gamehandler.leardboard.get(level)[dificulty]
	$Control/RecordActual/Record.text = String(point)

func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene("res://scenes/Menu.tscn")
