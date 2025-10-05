extends Node3D
class_name CannedFood

@onready var food: MeshInstance3D = $CSGBakedMeshInstance3D/Food

@export var completion_percentage: float = 0:
	set(new_value):
		completion_percentage = min(new_value, 100)
		
		if food == null: return
		adjust_mesh_level()

var got_scanned: bool = false

func _ready() -> void:
	adjust_mesh_level()

func adjust_mesh_level():
	var zero_to_one_scale = inverse_lerp(0.0, 100.0, completion_percentage)
	food.scale.y = 1 * zero_to_one_scale
	food.position.y = -0.2 * abs(zero_to_one_scale - 1)
