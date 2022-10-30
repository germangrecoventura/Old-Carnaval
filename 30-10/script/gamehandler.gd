extends Node

var leardboard:Array = [0,0,0]
var firstActive = true

func update_leardboard(level,point):
	if firstActive:
		leardboard[level] = point
		firstActive = false
	elif leardboard[level] > point:
		leardboard[level] = point
