extends "res://script/AbstractState.gd"


func update(delta:float):
	if parent.abduct == true:
		emit_signal("finished", "abduced_good")
	if parent.abduct_glitched == true:
		emit_signal("finished", "abduced_fail")
	if parent.position.x < 302:
		parent.velocity = Vector2(parent.velocity.x * -1,0)
		parent.set_linear_velocity(Vector2(200,0))
	elif parent.position.x > 1160:
		parent.velocity = Vector2(parent.velocity.x * -1,0)
		parent.set_linear_velocity(Vector2(-200,0))
	parent.apply_impulse(Vector2(0,0),parent.velocity)
