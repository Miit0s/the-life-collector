extends Node3D

@onready var guillotine: Guillotine = $Guillotine
@onready var point_system: PointSystem = $PointSystem

func _ready() -> void:
	point_system.show_game()

func trigger_guillotine():
	guillotine.slice_object()

func corpse_piece_validate():
	point_system.add_point()

func day_ended():
	get_tree().change_scene_to_file("uid://ngajd72kek4r")
