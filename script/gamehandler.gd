extends Node

var leardboard:Array = [0,0,0]
var already_played:Array = [false,false,false]

func update_leardboard(level,point):
	if !already_played[level]:
		already_played.remove(level)
		already_played.insert(level,true)
		leardboard[level] = point
	elif leardboard[level] > point:
		leardboard[level] = point
