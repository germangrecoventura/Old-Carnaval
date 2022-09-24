extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/Touch.visible = false
	Gamehandler.update_time()
	yield(get_tree().create_timer(5), "timeout")
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	get_tree().get_nodes_in_group("go")[0].text = "Go"
	$UI/Touch.visible = true
	yield(get_tree().create_timer(2), "timeout")
	get_tree().get_nodes_in_group("go")[0].visible = false
	yield(get_tree().create_timer(10), "timeout")
	get_tree().get_nodes_in_group("go")[0].text = "Consiguiendo vaca"
	get_tree().get_nodes_in_group("go")[0].visible = true
	$UI/Touch.queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if Gamehandler.time != 1:
		Gamehandler.time -= 1
		Gamehandler.update_time()
	
