extends Node
	
func _on_Return_pressed():
	self.queue_free()
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)
