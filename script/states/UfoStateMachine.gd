extends "res://script/states/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk
	}

