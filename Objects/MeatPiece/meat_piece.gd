extends RigidBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export_range(0, 255) var min_color_variation: int = 50
@export var completion_percentage: float = 0:
	set(new_value):
		completion_percentage = min(new_value, 100)
		
		if mesh_instance_3d == null: return
		adjust_material_color()

var got_scanned: bool = false

func adjust_material_color():
	var zero_to_one_scale = inverse_lerp(0.0, 100.0, completion_percentage)
	var color_variation: int = max(min_color_variation, (255 - 255 * zero_to_one_scale))
	var new_color_value: float = inverse_lerp(0.0, 255.0, color_variation)
	var material: StandardMaterial3D = mesh_instance_3d.material_override
	material.albedo_color = Color(new_color_value, new_color_value, new_color_value)
