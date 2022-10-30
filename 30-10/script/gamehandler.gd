extends Node

var leardboard:Array = [0,0,0]
var firstActive = true

func update_leardboard(level,point):
	if firstActive:
		leardboard[level] = point
		firstActive = false
	elif leardboard[level] > point:
		leardboard[level] = point

	#match point_leardboard:
	#	0:
	 #   	print("We are number one!")
		#2:
		#	print("Two are better than one!")
		#"test":
		#	print("Oh snap! It's a string!")
#	if point_leardboard == 0:
		
#	if point_leardboard > point:
#		leardboard[level] = point
#	var points = leardboard[level]
#3	if points[dificulty] == 0 && point > 0:
#		var list = []
#		var i = 0
#		while(i != dificulty):
#			list.append(point[i])
#			points.pop_back()
#			i+= 1
#		points.pop_back()
#		list.append(point)
#		list.append_array(points)
#		leardboard[level]= list
#	elif points[dificulty] > point:
#		var list = []
#		var i = 0
#		while(i != dificulty):
#			list.append(point[i])
#			points.pop_back()
#			i+= 1
#		points.pop_back()
#		list.append(point)
#		list.append_array(points)
#		leardboard[level]= list
		#pass
