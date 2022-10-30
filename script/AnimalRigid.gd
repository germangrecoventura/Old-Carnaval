extends RigidBody2D

onready var resultLeft = Physics2DTestMotionResult.new()
onready var resultRight = Physics2DTestMotionResult.new()

export(int) var impulse =-40
export(String) var texture
export (Vector2) var velocity = Vector2(-2,0)

func _ready():
	$Body.texture = load(texture)
	self.set_gravity_scale(4.0)
	
	
func _physics_process(delta):
	var hitLeft = self.test_motion(Vector2(256,0),false,0.08, resultLeft)
	var hitRight = self.test_motion(Vector2(20,0),false,0.08, resultRight)
	if hitLeft && resultLeft.collider_id == 1344:
		velocity = Vector2(-velocity.x,0)
	#print("Esto es izierda" + String(resultLeft.collider_id))
	#if hitRight && resultRight.collider_id != 1309 && resultRight.collider_id != 1347:
		#velocity = Vector2(velocity.x * -1,0)
	elif hitRight && resultRight.collider_id == 1347:
		#print("Esto es der" + String(resultRight.collider_id))
		velocity = Vector2(velocity.x * -1,0)
		set_applied_force(Vector2(-80,0))
		#velocity = Vector2(-velocity.x,0)
	#if hitLeft && result.collider_id == 1310:
	#	velocity = Vector2(-velocity.x,0)
	#if result.collider_id == 1349:
#		velocity = Vector2(-velocity.x,0)
	#if result.collider_id == 1310:
	#	velocity = Vector2(-velocity.x,0)
	#apply_impulse(Vector2(0,0),velocity)
	#var result = Physics2DTestMotionResult.new()
	#var hit = self.test_motion(Vector2(1036,0),false,0.08, result)
	#result.collider_id
	#if hit && result.collider_id != 1350: 
	#	if result.collider_id == 1308:
	#		velocity = Vector2(-velocity.x,0)
		#	print("Hola me pegue a la derecha")
		#	print(result.collider_id)
	apply_impulse(Vector2(0,0),velocity)

func _on_StaticFloor_body_entered(body):
	print(body)
	body.apply_impulse(Vector2.ZERO,Vector2(0,impulse))


func _on_Area2D2_body_entered(body):
		#print(body.name)
	#	body.velocity = Vector2(-velocity.x,0)
	#	body.apply_impulse(Vector2(0,0),velocity)
	pass

func _on_Area2D_body_entered(body):
		pass
		#print(body.name)
		#body.velocity = Vector2(-velocity.x,0)

func _on_Area2D2_body_exited(body):
	pass#body.get_node("CollisionShape2D").disabled = false


func _on_Area2D_body_exited(body):
	pass#body.get_node("CollisionShape2D").disabled = false
