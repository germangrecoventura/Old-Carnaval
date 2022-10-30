extends Node
	
func _on_Return_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	self.queue_free()


func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))
