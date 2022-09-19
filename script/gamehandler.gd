extends Node

var puntos = 0
var tiempo = 4
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_puntos():
	get_tree().get_nodes_in_group("puntos")[0].text = String(puntos)


func update_time():
	get_tree().get_nodes_in_group("tiempo")[0].text = String(tiempo%60)
