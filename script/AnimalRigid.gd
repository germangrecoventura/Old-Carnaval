extends RigidBody2D

export(int) var impulse =-40
export(String) var texture
export (Vector2) var velocity = Vector2(-2,0)

func _ready():
	$Body.texture = load(texture)
	self.set_gravity_scale(4.0)
	
func _physics_process(delta):
	if position.x < 302:
		velocity = Vector2(velocity.x * -1,0)
		set_linear_velocity(Vector2(200,0))
	elif position.x > 1160:
		velocity = Vector2(velocity.x * -1,0)
		set_linear_velocity(Vector2(-200,0))
	apply_impulse(Vector2(0,0),velocity)

func _on_StaticFloor_body_entered(body):
	body.apply_impulse(Vector2.ZERO,Vector2(0,impulse))
