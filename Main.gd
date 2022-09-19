extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Gamehandler.update_puntos()
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if Gamehandler.tiempo > 0:
		Gamehandler.tiempo -= 1
		Gamehandler.update_time()
	else:
		print("GO")
