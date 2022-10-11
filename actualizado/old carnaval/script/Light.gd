extends Sprite

#onready var cow = $"../../Cow"
#onready var ufo = $"../../Ufo"
onready var ala = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_area_entered(area):
#	print(area)
	#if(ala):
	#	ala = false
	#	var final_pos:Vector2 = cow.global_position
	#	final_pos.y -= 200
	#	var move_tween:SceneTreeTween = get_tree().create_tween()
	#	move_tween.tween_property(cow,"global_position",final_pos,2.0).set_delay(3)
#	else:
	#	var final_pos:Vector2 = cow.global_position
	#	final_pos.y -= 200
		#var move_tween:SceneTreeTween = get_tree().create_tween()
		#move_tween.tween_property(cow,"global_position",final_pos,2.0)
	pass
