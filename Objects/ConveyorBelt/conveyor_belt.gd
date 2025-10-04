extends Node3D
class_name ConveyorBelt

@export var objet_to_spawn: PackedScene
@export var conveyor_speed: float = 1
@export var spawn_object_x: float = -5
@export var despawn_object_x: float = 5
@export var is_active: bool = true
@export var distance_between_object_spawn: float = 5

@onready var conveyor_mesh: MeshInstance3D = $ConveyorMesh

var _distance_between_last_object: float = 0

func _ready() -> void:
	spawn_object()

func _physics_process(delta: float) -> void:
	if not is_active: return
	
	var distance_to_add = delta * conveyor_speed
	
	conveyor_mesh.position.x += distance_to_add
	_distance_between_last_object += distance_to_add
	
	if _distance_between_last_object >= distance_between_object_spawn:
		spawn_object()
		_distance_between_last_object = 0
	
	check_child_despawn()

func spawn_object():
	var object: Node3D = objet_to_spawn.instantiate()
	
	object.position.x = conveyor_mesh.to_local(Vector3(spawn_object_x, 0, 0)).x
	
	conveyor_mesh.add_child(object)

func check_child_despawn():
	var objects_on_conveyor: Array[Node] = conveyor_mesh.get_children()
	
	for object: Node3D in objects_on_conveyor:
		if object.global_position.x >= despawn_object_x:
			object.queue_free()
