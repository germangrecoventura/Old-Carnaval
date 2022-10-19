extends Node

var leardboard = {"HammerLevel": [0,0,0]}

func update_leardboard(level,dificulty,point):
	var points = leardboard.get(level)
	if points[dificulty] > point:
		var list = []
		var i = 0
		while(i != dificulty):
			list.append(point[i])
			points.pop_back()
			i+= 1
		points.pop_back()
		list.append(point)
		list.append_array(points)
		leardboard[level]= list
