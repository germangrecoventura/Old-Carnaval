extends Node

var puntos = 0
var time = 5
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_puntos():
	get_tree().get_nodes_in_group("puntos")[0].text = String(puntos)


func update_time():
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
