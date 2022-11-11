extends "res://script/Level.gd"

func _on_TimerTimeGame_timeout():
	touchAbduction.queue_free()
	animationUfo.stop()
	animationUfo.queue_free()
	ufo.queue_free()
	joystyck.queue_free()
	for child in $Animals.get_children():
			child.queue_free()
	if !is_winner():
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
