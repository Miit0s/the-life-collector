extends Node3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var scan_system: PercentageDisplaySystem = $SubViewport/ScanSystem

@export var minimum_percentage: float = 80
@export var use_sliced: bool = false

signal scanned_object_is_good
signal scanned_object_is_bad

func _ready() -> void:
	scan_system.change_goal(int(minimum_percentage))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not ray_cast_3d.is_colliding(): return
	
	var collider: Area3D = ray_cast_3d.get_collider()
	var object_to_scan: Node3D = collider.get_parent_node_3d()
	
	if object_to_scan.got_scanned: return
	
	object_to_scan.got_scanned = true
	
	if use_sliced:
		if object_to_scan.got_sliced:
			scanned_object_is_good.emit()
		else:
			scanned_object_is_bad.emit()
		
		return
	
	scan_system.change_current_value(object_to_scan.completion_percentage)
	if object_to_scan.completion_percentage >= minimum_percentage:
		scanned_object_is_good.emit()
	else:
		scanned_object_is_bad.emit()
