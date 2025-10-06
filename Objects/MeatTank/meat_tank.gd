extends Node3D

@onready var meat: MeshInstance3D = $Meat

@export var max_percentage_wanted: float = 80
@export var min_percentage_wanted: float = 15
@export var decrease_speed: float = 10

var completion_percentage: float = 100:
	set(new_value):
		completion_percentage = max(min(new_value, 100), 0)
		adjust_mesh_level()
var meat_size: Vector3

func _ready() -> void:
	meat_size = meat.get_aabb().size
	adjust_mesh_level()

func _physics_process(delta: float) -> void:
	completion_percentage -= delta * decrease_speed

func adjust_mesh_level():
	if completion_percentage <= 0:
		meat.hide()
	else:
		meat.show()
	
	var zero_to_one_scale = inverse_lerp(0.0, 100.0, completion_percentage)
	meat.scale.y = 1 * zero_to_one_scale
	meat.position.y = -(meat_size.y / 2) * abs(zero_to_one_scale - 1)
