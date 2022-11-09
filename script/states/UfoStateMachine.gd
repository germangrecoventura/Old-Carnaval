extends "res://script/states/AbstractStateMachine.gd"

func _ready():
	states_map = {
		"normal": $Normal,
		"damaged": $Damaged,
		"pre_glitch": $PreGlitch,
		"glitch": $Glitch
	}

