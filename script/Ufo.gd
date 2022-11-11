extends Node2D

onready var touchAbduction = $"../ControlTouchAbduction/TouchAbduction"
onready var statusUfo = 0

export var speed : float = 400

func _ready():
	$StateMachine.set_parent(self)

func _on_Area2D_body_entered(body):
	if body.name == "Cloud":
		body.get_node("Body").texture = load("res://assets/storm cloud/Cloud with ray.png")
		touchAbduction.visible= false
		touchAbduction.set_process_input(false)


func _on_Area2D_body_exited(body):
	if body.name == "Cloud" && $"../TimerCountDown".is_stopped() && $Light/TimerAbduct.is_stopped() && $Light/TimerReturnLight.is_stopped():
		body.get_node("Body").texture = load("res://assets/storm cloud/Cloud.png")
		touchAbduction.visible= true
		touchAbduction.set_process_input(true)
