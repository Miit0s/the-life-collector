extends Node3D

@onready var point_system: PointSystem = $PointSystem
@onready var grinder: Grinder = $Grinder
@onready var object_dispenser: ObjectDispenser = $ObjectDispenser

@export var cooldown_between_point_loose: float = 5
@export var cooldown_between_object_spawn: float = 2

var _can_loose_point: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_system.show_game()
	
	await get_tree().create_timer(5).timeout
	object_dispenser.spawn_object_one_shot()

func start_grinder():
	grinder.grinder_activate = true

func stop_grinder():
	grinder.grinder_activate = false

func piece_grinded():
	point_system.add_point()
	await get_tree().create_timer(cooldown_between_object_spawn).timeout
	object_dispenser.spawn_object_one_shot()

func grinder_use_for_nothing():
	_loose_point()

func _loose_point():
	if not _can_loose_point: return
	
	_can_loose_point = false
	point_system.remove_point()
	await get_tree().create_timer(cooldown_between_point_loose).timeout
	_can_loose_point = true

func day_end():
	get_tree().change_scene_to_file("uid://ngajd72kek4r")
