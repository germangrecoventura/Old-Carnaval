extends Sprite


func _on_Area2D_area_entered(area):
	$"../Cow".visible = false
