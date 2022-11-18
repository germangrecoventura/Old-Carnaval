extends Node2D

onready var touchAbduction = $"../ControlTouchAbduction/TouchAbduction"
onready var statusUfo = 0
onready var sfxThunder = $"../SFX"

export var speed : float = 400

func _ready():
	$StateMachine.set_parent(self)

func _on_Area2D_body_entered(body):
	if body.name == "Cloud":
		var audio_file = "res://sound/thunder.ogg"
		var sound = load(audio_file)
		sfxThunder.stream = sound
		sfxThunder.play()
		body.get_node("Ray").visible = true
		touchAbduction.visible= false
		touchAbduction.set_process_input(false)


func _on_Area2D_body_exited(body):
	if body.name == "Cloud" && $"../TimerCountDown".is_stopped() && $Light/TimerAbduct.is_stopped() && $Light/TimerReturnLight.is_stopped():
		body.get_node("Ray").visible = false
		touchAbduction.visible= true
		touchAbduction.set_process_input(true)
