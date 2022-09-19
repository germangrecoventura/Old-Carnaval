extends Node

var vidas = 3
var offset_vidas = 80
var lista_vidas = []
export (PackedScene) var spr_vidas

# Called when the node enters the scene tree for the first time.
func _ready():
	crear_vidas()
	Gamehandler.update_puntos()
	Gamehandler.update_time()

func crear_vidas():
	for i in vidas:
		var new_vida = spr_vidas.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(new_vida)
		new_vida.global_position.x += offset_vidas * i
		lista_vidas.append(new_vida)

func quitar_vida():
	vidas -= 1
	lista_vidas[vidas].queue_free()
	
func agregar_vida():
	vidas +=1
	var newVida = spr_vidas.instance()
	get_tree().get_nodes_in_group("gui")[0].add_child(newVida)
	newVida.global_position.x += offset_vidas * (vidas - 1)
	lista_vidas.append(newVida)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if Gamehandler.tiempo > 0:
		Gamehandler.tiempo -= 1
		Gamehandler.update_time()
	else:
		print("GO")
