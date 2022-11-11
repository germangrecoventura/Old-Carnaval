extends KinematicBody2D

export(int) var speed=3
export (Texture) var texture

var velocity=Vector2(100,0)

func _ready():
	get_node("Body").texture = texture
	
func _physics_process(delta):
	var collision=move_and_collide(velocity*delta*speed)
	if collision:
		velocity=velocity.bounce(collision.normal)
