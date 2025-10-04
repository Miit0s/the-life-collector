extends Node3D
class_name Dispenser

@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var percentage_to_add_to_can: float = 0.5
@export var cooldown: float = 1
@export var ray_cast_enable_offset: float = 0.2

var is_dispensing: bool = false:
	set(new_value):
		if is_in_cooldown: return
		
		is_dispensing = new_value
		gpu_particles_3d.emitting = new_value
		
		if new_value:
			start_ray_cast()
		else:
			stop_ray_cast()

var is_in_cooldown: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not ray_cast_3d.is_colliding(): return
	
	var collider: Area3D = ray_cast_3d.get_collider()
	var can_to_fill: CannedFood = collider.get_parent_node_3d()
	can_to_fill.completion_percentage += percentage_to_add_to_can

func set_dispenser_in_cooldown():
	is_in_cooldown = true
	await get_tree().create_timer(cooldown).timeout
	is_in_cooldown = false

func start_ray_cast():
	await get_tree().create_timer(ray_cast_enable_offset).timeout
	ray_cast_3d.enabled = true

func stop_ray_cast():
	await get_tree().create_timer(ray_cast_enable_offset).timeout
	ray_cast_3d.enabled = false
