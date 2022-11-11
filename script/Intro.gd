extends Node

onready var tween = $Tween
onready var background = $Background
onready var logo = $WorldEnvironment/Logo
onready var ufo = $Ufo
onready var timerEntryLogo = $TimerEntryLogo
onready var timerEntryUfo = $TimerEntryUfo
onready var timerOutLogo = $TimerOutLogo
onready var timerOutUfo = $TimerOutUfo
onready var animation = $AnimationPlayer

export(PackedScene) var next_scene

func _ready():
	Gamehandler.leardboard = [0,0,0]
	timerEntryLogo.start()
	tween.interpolate_property(logo,"modulate",Color(0,0,0,0),Color(1,1,1,1.1),timerEntryLogo.wait_time)
	tween.start()


func _on_TimerEntryLogo_timeout():
	timerEntryLogo.queue_free()
	timerEntryUfo.start()
	animation.play("ufo")
	tween.interpolate_property(ufo,"rect_position",ufo.rect_position,Vector2(ufo.rect_position.x,105),timerEntryUfo.wait_time)
	tween.start()
	
	
func _on_TimerEntryUfo_timeout():
	timerEntryUfo.queue_free()
	timerOutLogo.start()
	tween.interpolate_property(logo.material,"shader_param/progress",0,1,timerOutLogo.wait_time)
	tween.start()

	
func _on_TimerOutLogo_timeout():
	timerOutLogo.queue_free()
	timerOutUfo.start()
	tween.interpolate_property(ufo,"rect_position",ufo.rect_position,Vector2(ufo.rect_position.x,-175),timerOutUfo.wait_time)
	tween.start()


func _on_TimerOutUfo_timeout():
	timerOutUfo.stop()
	self.queue_free()
	get_tree().change_scene_to(next_scene)   


