extends KinematicBody2D

export(int) var speed=3
export (String) var texture

var velocity=Vector2(100,0)

func _ready():
	$Body.texture = load(texture)
	
func _physics_process(delta):
	var collision=move_and_collide(velocity*delta*speed)
	if collision:
		velocity=velocity.bounce(collision.normal)
