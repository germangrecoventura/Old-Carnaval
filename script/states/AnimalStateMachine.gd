extends "res://script/states/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"abduced_good": $AbducedGood,
		"abduced_fail": $AbducedFail,
		"walk": $Walk,
		"dead": $Dead
	}

