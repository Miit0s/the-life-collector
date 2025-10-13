extends Node3D
class_name Oven

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var oven_power: float = 1

signal meat_has_trigger_area

#True if the oven can be actived by the user
var is_oven_active: bool = false
#True if the oven is being activated by the user
var is_oven_running: bool = false

func start_oven():
	if not is_oven_active: return
	
	animation_player.play("OvenStart")
	is_oven_running = true

func stop_oven():
	if not is_oven_active: return
	
	is_oven_running = false
	animation_player.play_backwards("OvenStart")

func _process(delta: float) -> void:
	if not is_oven_running or not is_oven_active: return
	if not ray_cast_3d.is_colliding(): return
	
	var collider: RigidBody3D = ray_cast_3d.get_collider()
	
	collider.completion_percentage += oven_power * delta


func _on_meat_trigger_zone_body_entered(_body: Node3D) -> void:
	meat_has_trigger_area.emit()
