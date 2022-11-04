extends RigidBody2D

export(int) var impulse =-40
export(Texture) var texture
export (Vector2) var velocity = Vector2(-2,0)
export (int) var gravity = 4.0

onready var abduct = false
onready var abduct_glitched = false

onready var state = $StateMachine

func _ready():
	state.set_parent(self)
	$Body.texture = texture
	self.set_gravity_scale(gravity)

func _on_StaticFloor_body_entered(body):
	body.apply_impulse(Vector2.ZERO,Vector2(0,impulse))
