extends Control

func _on_Jugar_pressed():
	get_tree().change_scene("res://scenes/InformationLevel.tscn")   


func _on_Salir_pressed():
	get_tree().quit()

