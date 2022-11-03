extends Node

signal e

export (String) var level
export (PackedScene) var retry
export (PackedScene) var home
export (PackedScene) var listLevel

func _on_Retry_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene_to(retry)

func update_maximus_points():
	var point = Gamehandler.leardboard[level]
	$RecordActual/Record.text = String(point)

func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene_to(home)


func _on_ListLevel_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	get_tree().change_scene_to(listLevel)
