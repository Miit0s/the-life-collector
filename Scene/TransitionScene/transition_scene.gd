extends Control
class_name TransitionScene

enum Day {
	DAY_1,
	DAY_2,
	DAY_3,
	DAY_4,
	DAY_5,
	DAY_6
}

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var wait_time_for_begin_transition: float = 2
var wait_time_for_end_transition: float = 5

var text_day_one: String = "The work isn't great and I'm only paid enough to keep living in my home, but at least I can leave with a canned meal every evening."
var text_day_two: String = "I don't know where this mix they make comes from, but it's definitely not good. At least it keeps me from starving.\nIf only the rent were cheaper, I could eat something else."
var text_day_three: String = "Another day at work done, all so I can go home, eat this disgusting box meal and pay that bloody rent collector.\nI feel like I'm living like a prisoner."
var text_day_four: String = "The same cycle. Over and over again. Doing this miserable job all day long, just to pay my rent and eat this disgusting mixture.\nWhat have I done to deserve this?"
var text_day_five: String = "Will this nightmare ever end? Will I ever manage to break the cycle?\nI don't know if I can take this much longer."
var text_day_six: String = "I can no longer do this, I just can't.\nIt's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. It's time for me to break this cycle. "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(wait_time_for_begin_transition).timeout
	
	var current_day: Day = GlobalValue.current_day as Day
	match current_day:
		Day.DAY_1:
			display_text_and_start_anim(text_day_one, "Day1")
		Day.DAY_2:
			display_text_and_start_anim(text_day_two, "Day2")
		Day.DAY_3:
			display_text_and_start_anim(text_day_three, "Day3")
		Day.DAY_4:
			display_text_and_start_anim(text_day_four, "Day4")
		Day.DAY_5:
			display_text_and_start_anim(text_day_five, "Day5")
		Day.DAY_6:
			display_text_and_start_anim(text_day_six, "Day6")

func display_text_and_start_anim(text: String, animation_name: String):
	label.text = text
	animation_player.play(animation_name)
	await animation_player.animation_finished
	await get_tree().create_timer(wait_time_for_end_transition).timeout
	animation_player.play("FadeOut")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("uid://ct0tql2yu45s")
