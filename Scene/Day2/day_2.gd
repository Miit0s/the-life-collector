extends Node3D

@onready var point_system: PointSystem = $PointSystem
@onready var object_dispenser: ObjectDispenser = $ObjectDispenser
@onready var meat_tank: MeatTank = $MeatTank

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_system.show_game()
	await get_tree().create_timer(2).timeout
	meat_tank.is_decreasing = true

func _start_holding_button() -> void:
	object_dispenser.spawn_object = true

func _stop_holding_button() -> void:
	object_dispenser.spawn_object = false

func win_point():
	point_system.add_point()

func loose_point():
	point_system.remove_point()

func day_ended():
	get_tree().change_scene_to_file("uid://ngajd72kek4r")
