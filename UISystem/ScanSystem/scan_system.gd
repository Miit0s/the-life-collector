extends Control
class_name ScanSystem

@onready var goal: Label = $Goal
@onready var current: Label = $Current
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var goal_string: String = "Goal"

func change_goal(value: int):
	goal.text = goal_string + " : " + str(value) + " %"

func change_current_value(value: int):
	current.text = str(value) + " %"
	animation_player.play("NewCurrentScore")
