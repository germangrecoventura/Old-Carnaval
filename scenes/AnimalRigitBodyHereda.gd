extends "res://script/AnimalRigid.gd"

#var left = true
#var right = true
#var move = true

#func _physics_process(delta):
#	if(move):
#		apply_impulse(Vector2(0,0),velocity)
	
	
#func _on_Area2D2_body_entered(body):
#	if right:
#		left = true
#		right = false
#		print(body.name)
#		move = false
#		velocity = Vector2(-velocity.x,0)
#		move = true


#func _on_AreaLeft_body_entered(body):
#	if left:
#		left = false
#		right = true
#		print(body.name)
#		move = false
#		velocity = Vector2(-velocity.x,0)
#		move = true


#func _on_AreaRight_body_entered(body):
#	if right:
#		left = true
#		right = false
#		print(body.name)
#		move = false
#		velocity = Vector2(-velocity.x,0)
#		move = true
