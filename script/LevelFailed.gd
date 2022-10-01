extends Control

signal e


func _on_Retry_pressed():
	pass # Replace with function body.

func update_maximus_points():
	var point = Gamehandler.leardboard.get("HammerLevel")[0]
	$Label.text = String(point)

func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene("res://scenes/Menu.tscn")
