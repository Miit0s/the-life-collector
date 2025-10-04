extends Control
class_name PointSystem

@onready var label: Label = $Label

@export var text_before_score: String = "Score"
@export var point_to_add: int = 1
@export var point_to_remove: int = 1
@export var point_to_reach: int = 100

var _current_point: int = 0:
	set(new_value):
		_current_point = max(0, new_value)

signal score_reach

func _ready() -> void:
	display_text()

func add_point():
	_current_point += point_to_add
	display_text()
	
	if _current_point >= point_to_reach:
		score_reach.emit()

func remove_point():
	_current_point += point_to_remove
	display_text()

func display_text():
	label.text = text_before_score + " : " + str(_current_point) + "/" + str(point_to_reach)
