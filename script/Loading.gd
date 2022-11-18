extends Control

export(PackedScene) var next_scene

onready var animation = $UfoAnimation

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("ufo_normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Timer.queue_free()
	self.queue_free()
	get_tree().change_scene_to(next_scene)   
