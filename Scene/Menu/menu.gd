extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start: Button = $Control/Start

func _on_start_pressed() -> void:
	start.disabled = true
	animation_player.play("FadeIn")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file("uid://btdn2gikdsyge")

func _on_quit_pressed() -> void:
	get_tree().quit()
