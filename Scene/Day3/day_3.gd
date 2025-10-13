extends Node3D

@onready var point_system: PointSystem = $PointSystem
@onready var oven: Oven = $Oven
@onready var conveyor_belt: ConveyorBelt = $ConveyorBelt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_system.show_game()

func activate_oven():
	if not oven.is_oven_active: return
	
	oven.start_oven()

func desactivate_oven():
	if not oven.is_oven_active or not oven.is_oven_running: return
	
	oven.stop_oven()
	oven.is_oven_active = false
	conveyor_belt.is_active = true

func meat_has_reach_oven():
	conveyor_belt.is_active = false
	oven.is_oven_active = true

func meat_have_good_heating():
	point_system.add_point()
