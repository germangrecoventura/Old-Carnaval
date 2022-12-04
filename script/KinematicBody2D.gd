extends KinematicBody2D

export(int) var speed=3

var velocity=Vector2(100,0)

func _ready():
	$Ray.visible = false
	
func _physics_process(delta):
	var collision=move_and_collide(velocity*delta*speed)
	if collision:
		velocity=velocity.bounce(collision.normal)
