extends RigidBody2D

export(int) var impulse =-40
export(String) var texture
export (Vector2) var velocity = Vector2(-2,0)

func _ready():
	$Body.texture = load(texture)
	self.set_gravity_scale(4.0)
	
func _physics_process(delta):
		apply_impulse(Vector2(0,0),velocity)
	
	
func _on_StaticFloor_body_entered(body):
	print(body)
	body.apply_impulse(Vector2.ZERO,Vector2(0,impulse))


func _on_Area2D2_body_entered(body):
		print(body.name)
		body.velocity = Vector2(-velocity.x,0)
		body.apply_impulse(Vector2(0,0),velocity)

func _on_Area2D_body_entered(body):
		print(body.name)
		body.velocity = Vector2(-velocity.x,0)

func _on_Area2D2_body_exited(body):
	pass#body.get_node("CollisionShape2D").disabled = false


func _on_Area2D_body_exited(body):
	pass#body.get_node("CollisionShape2D").disabled = false
