extends Camera3D
class_name CameraWithPixelEffect

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh_instance_3d.show()
