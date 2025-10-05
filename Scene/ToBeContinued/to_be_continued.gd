extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("FadeIn")

func _on_button_pressed() -> void:
	get_tree().quit()
