extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("accept"):
		##$AnimationPlayer.play("transitionBlack")
	##	yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene("res://scenes/Menu.tscn")
	if Input.is_action_just_pressed("cancel"):
		get_tree().change_scene("res://scenes/Menu.tscn")
	if Input.is_action_just_pressed("retry"):
		get_tree().change_scene("res://scenes/Menu.tscn")
