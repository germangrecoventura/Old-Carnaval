extends Node

signal e

export (int) var level
export (String) var retry
export (PackedScene) var listLevel
export (PackedScene) var menu

func acept_signal():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()

	
func update_results(retryToPlay,levelToPlay):
	self.retry = retryToPlay
	self.level = levelToPlay
	var point = Gamehandler.leardboard[level]
	$RecordActual/Record.text = String(point)
	


func _on_Retry_pressed():
	acept_signal()
	get_tree().change_scene(retry)


func _on_Cancel_pressed():
	acept_signal()
	get_tree().change_scene_to(menu)


func _on_ListLevel_pressed():
	acept_signal()
	get_tree().change_scene_to(listLevel)
