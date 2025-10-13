extends Control
class_name PercentageDisplaySystem

@onready var min_label: Label = $Min
@onready var max_label: Label = $Max
@onready var current: Label = $Current
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var min_string: String = "Min"
var max_string: String = "Max"

func change_goal(min_value: int,max_value: int):
	min_label.text = min_string + " : " + str(min_value) + " %"
	max_label.text = max_string + " : " + str(max_value) + " %"
	
	if max_value == 100: max_label.hide()

func change_current_value(value: int):
	current.text = str(value) + " %"
	animation_player.play("NewCurrentScore")
