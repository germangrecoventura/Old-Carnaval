extends "res://script/Level.gd"

onready var sfx_rain = $SFXRain

func _ready():
	points = 0
	animationPlayer.play("background")
	$AnimationRain.play("rain")
	$Ufo/Light/Area2D/CollisionShape2D.disabled = true
	joystyck.visible = false
	hide_ui()
	countdown.text = String(time%60)
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var audio_rain = "res://sound/rain_thunder_loop.wav"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	var sfxRain = load(audio_rain)
	sfx_rain.stream = sfxRain
	sfx_rain.play()


func _on_TimerTimeGame_timeout():
	$Cloud.queue_free()
	touchAbduction.queue_free()
	animationUfo.stop()
	animationUfo.queue_free()
	ufo.queue_free()
	joystyck.queue_free()
	for child in $Animals.get_children():
			child.queue_free()
	if !animals_abducted.has("Cow"):
		transitionToFinish(timerFail,"res://sound/losegamemusic.ogg",4.16)
	elif points == 1:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerThree,"res://sound/winneris.ogg",3.87)
	elif points == 2:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerTwo,"res://sound/winneris.ogg",3.87)
	else:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerOne,"res://sound/winneris.ogg",3.87)
