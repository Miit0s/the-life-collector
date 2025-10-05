extends Node3D
class_name ObjectDispenser

@onready var marker_3d: Marker3D = $Marker3D

@export var object_to_spawn: PackedScene
@export var spawn_cooldown: float = 0.5

var spawn_object: bool = false

var _can_spawn: bool = true

func spawn_object_one_shot():
	if not _can_spawn: return
	
	var object: Node3D = object_to_spawn.instantiate()
	object.position = marker_3d.position
	
	add_child(object)
	
	set_the_dispenser_in_cooldown()

func _process(_delta: float) -> void:
	if not spawn_object or not _can_spawn: return
	
	spawn_object_one_shot()

func set_the_dispenser_in_cooldown():
	_can_spawn = false
	await get_tree().create_timer(spawn_cooldown).timeout
	_can_spawn = true
