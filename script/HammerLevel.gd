extends Node2D

var time = 5
onready var touch = $UI/Touch

func _ready():
	touch.visible = false
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	$TimerStart.start()
	$TimerGo.start()
	

func _on_TimerCountDown_timeout():
	if time != 1:
		time -= 1
		get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	

func _on_TimerStart_timeout():
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	get_tree().get_nodes_in_group("go")[0].visible = true
	get_tree().get_nodes_in_group("go")[0].text = "Go"
	touch.visible = true
	$TimerGo.start()
	
	


func _on_TimerGo_timeout():
	get_tree().get_nodes_in_group("go")[0].visible = false
	$TimerTimeGame.start()
	yield(get_tree().create_timer(10), "timeout")
	


func _on_TimerTimeGame_timeout():
	get_tree().get_nodes_in_group("go")[0].text = "Consiguiendo vaca"
	get_tree().get_nodes_in_group("go")[0].visible = true
	touch.queue_free()
