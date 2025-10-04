extends Node3D

@onready var dispenser: Dispenser = $Dispenser
@onready var point_system: PointSystem = $PointSystem

@export var dispenser_activation_duration: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func activate_dispenser():
	if dispenser.is_dispensing: return
	if dispenser.is_in_cooldown: return
	
	dispenser.is_dispensing = true
	await get_tree().create_timer(dispenser_activation_duration).timeout
	dispenser.is_dispensing = false
	dispenser.set_dispenser_in_cooldown()

func canned_food_validate():
	point_system.add_point()

func day_ended():
	print("Day_ended")
