extends "res://script/Level.gd"

func _ready():
	points = 0
	animationPlayer.play("background")
	$Ufo/Light/Area2D/CollisionShape2D.disabled = true
	joystyck.visible = false
	hide_ui()
	joystyck.visible = true
	countdown.text = String(time%60)
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var audio_rain = "res://sound/rain_thunder_loop.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	audio_file = "res://sound/night-sounds-august-54695.ogg"
	sfx = load(audio_file)
	audioBackground.stream = sfx
	audioBackground.play()


func _on_TimerTimeGame_timeout():
	audioBackground.stop()
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

func _on_TimerStart_timeout():
	countdown.text = "Go"
	$TimerGo.start()
