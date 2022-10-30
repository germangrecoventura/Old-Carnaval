extends RigidBody2D

export(int) var impulse =-40
export (Vector2) var velocity = Vector2(-2,0)

var move:bool
var left = true
var right = true

func _ready():
	move = true
	self.set_gravity_scale(4.0)
	
func _physics_process(delta):
	if(move):
		apply_impulse(Vector2(0,0),velocity)

func _on_AreaFloor_body_entered(body):
	self.apply_impulse(Vector2.ZERO,Vector2(0,-40))


func _on_Area2D2_body_entered(body):
	if right:
		left = true
		right = false
		print(body.name)
		move = false
		velocity = Vector2(-velocity.x,0)
		move = true


func _on_AreaLeft_body_entered(body):
	if left:
		left = false
		right = true
		print(body.name)
		move = false
		velocity = Vector2(-velocity.x,0)
		move = true


func _on_AreaRight_body_entered(body):
	if right:
		left = true
		right = false
		print(body.name)
		move = false
		velocity = Vector2(-velocity.x,0)
		move = true
