extends "res://script/states/AbstractState.gd"

onready var particles = $"../../Particles2D"
onready var sfxAnimal = $"../../SFX"

func enter():
	if parent.abduct == false:
		emit_signal("finished", "walk")
	else:
		var move_tween:SceneTreeTween = get_tree().create_tween()
		move_tween.tween_property(parent,"global_position",Vector2(parent.global_position.x,280),1.3)
		if get_tree().get_nodes_in_group("cow").has(parent):
			particles.texture = load("res://assets/freefantasygui/png/Estrella.png")
			particles.process_material.spread = 45
			particles.emitting = true
			var audio_file = "res://sound/SoundStar.ogg"
			var sfx = load(audio_file)
			sfxAnimal.stream = sfx
			sfxAnimal.play()
		else:
			particles.texture = load("res://assets/enojo.png")
			particles.process_material.spread = 1
			particles.emitting = true
			var audio_file = "res://sound/invalid-selection-39351.ogg"
			var sfx = load(audio_file)
			sfxAnimal.stream = sfx
			sfxAnimal.play()
		yield(get_tree().create_timer(1.3), "timeout")
		emit_signal("finished", "dead")


