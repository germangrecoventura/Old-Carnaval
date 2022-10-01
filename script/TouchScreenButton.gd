extends TouchScreenButton

export (int) var points_to_add

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("touch"):
		$"../..".points += 20
