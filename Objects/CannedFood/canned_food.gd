extends Node3D
class_name CannedFood

@export var completion_percentage: float = 0:
	set(new_value):
		completion_percentage = min(new_value, 100)

var got_scanned: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
