extends Node3D
class_name MeatTank

@onready var meat: MeshInstance3D = $Meat
@onready var validation_display_system: ValidationDisplaySystem = $SubViewport/ValidationDisplaySystem

@export var meat_to_add_by_block: float = 2
@export var max_percentage_wanted: float = 80
@export var min_percentage_wanted: float = 15
@export var decrease_speed: float = 1
@export var max_speed: float = 10
@export var speedup_cooldown: float = 5
@export var speedup_increase_value: float = 1
@export var point_cooldown: float = 0.5
@export var warning_when_close_to_percentage_by: float = 5

var completion_percentage: float = 50:
	set(new_value):
		completion_percentage = max(min(new_value, 100), 0)
		adjust_mesh_level()

var meat_size: Vector3
var is_decreasing: bool = false

var _can_loose_point: bool = true
var _can_win_point: bool = true
var _can_speedup: bool = true

signal has_correct_percentage
signal has_incorrect_percentage

func _ready() -> void:
	meat_size = meat.get_aabb().size
	adjust_mesh_level()

func _physics_process(delta: float) -> void:
	if not is_decreasing: return
	
	completion_percentage -= delta * decrease_speed
	
	speedup()
	if completion_percentage > max_percentage_wanted or completion_percentage < min_percentage_wanted:
		validation_display_system.set_error_state()
		loose_point()
	elif completion_percentage > max_percentage_wanted - warning_when_close_to_percentage_by or \
	completion_percentage < min_percentage_wanted + warning_when_close_to_percentage_by:
		validation_display_system.set_near_error_state()
		win_point()
	else:
		validation_display_system.set_validate_state()
		win_point()

func adjust_mesh_level():
	if completion_percentage <= 0:
		meat.hide()
		return
	else:
		meat.show()
	
	var zero_to_one_scale = inverse_lerp(0.0, 100.0, completion_percentage)
	meat.scale.y = 1 * zero_to_one_scale
	meat.position.y = -(meat_size.y / 2) * abs(zero_to_one_scale - 1)

func meat_enter_tank(body: Node3D):
	body.queue_free()
	completion_percentage += meat_to_add_by_block

func win_point():
	if not _can_win_point: return
	
	_can_win_point = false
	has_correct_percentage.emit()
	await get_tree().create_timer(point_cooldown).timeout
	_can_win_point = true

func loose_point():
	if not _can_loose_point: return
	
	_can_loose_point = false
	has_incorrect_percentage.emit()
	await get_tree().create_timer(point_cooldown).timeout
	_can_loose_point = true

func speedup():
	if not _can_speedup: return
	
	_can_speedup = false
	decrease_speed += speedup_increase_value
	await get_tree().create_timer(speedup_cooldown).timeout
	_can_speedup = true
