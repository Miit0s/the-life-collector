extends Control
class_name QuestSystem

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var text_to_display: String = ""

func new_quest(quest_text: String):
	if text_to_display == "":
		text_to_display = quest_text
		animation_player.play("DisplayFirstQuest")
		return
	
	text_to_display = quest_text
	animation_player.play("DisplayNewQuest")

func change_text_for_new_one():
	label.text = text_to_display
