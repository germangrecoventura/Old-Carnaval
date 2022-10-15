extends Sprite

func _on_Area2D_body_entered(body):
	print(body) # Replace with function body.
	$Area2D.set_process(false)
	var move_tween:SceneTreeTween = get_tree().create_tween()
	move_tween.tween_property(body,"global_position",Vector2(body.global_position.x,211),2.0)
	yield(get_tree().create_timer(2), "timeout")
	body.queue_free()
