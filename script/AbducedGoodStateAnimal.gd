extends "res://script/AbstractState.gd"


func enter():
	if parent.abduct == false:
		emit_signal("finished", "walk")
	else:
		var move_tween:SceneTreeTween = get_tree().create_tween()
		move_tween.tween_property(parent,"global_position",Vector2(parent.global_position.x,280),1.3)
		yield(get_tree().create_timer(1.3), "timeout")
		emit_signal("finished", "dead")


