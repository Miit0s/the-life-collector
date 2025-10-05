extends Node3D
class_name Guillotine

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cutter: MeshInstance3D = $Cutter
@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var conveyor_belt: ConveyorBelt
@export var corpse: PackedScene
@export var conveyor_stop_duration: float = 0.5

var mesh_slicer: MeshSlicer = MeshSlicer.new()

func _ready() -> void:
	add_child(mesh_slicer)

func slice_object():
	animation_player.play("Cut")

func _slice_trigger():
	if not ray_cast_3d.is_colliding(): return
	
	conveyor_belt.is_active = false
	
	var collider: Area3D = ray_cast_3d.get_collider()
	var object_to_slide: Node3D = collider.get_parent_node_3d()
	var mesh_for_object_to_slide: MeshInstance3D = collider.get_parent_node_3d().mesh_instance_3d
	
	var cutter_transform = cutter.global_transform
	cutter_transform.origin = mesh_for_object_to_slide.to_local(cutter_transform.origin)
	cutter_transform.basis.x = mesh_for_object_to_slide.to_local(cutter_transform.basis.x + mesh_for_object_to_slide.global_position)
	cutter_transform.basis.y = mesh_for_object_to_slide.to_local(cutter_transform.basis.y + mesh_for_object_to_slide.global_position)
	cutter_transform.basis.z = mesh_for_object_to_slide.to_local(cutter_transform.basis.z + mesh_for_object_to_slide.global_position)
	
	var meshes: Array[ArrayMesh] = mesh_slicer.slice_mesh(cutter_transform, mesh_for_object_to_slide.mesh)
	
	mesh_for_object_to_slide.mesh = meshes[0]
	object_to_slide.got_sliced = true
	create_a_new_sliced_corpse(object_to_slide.global_position, meshes[1])
	
	await get_tree().create_timer(conveyor_stop_duration).timeout
	conveyor_belt.is_active = true

func create_a_new_sliced_corpse(object_slided_position: Vector3, mesh: ArrayMesh):
	var new_corpse: Node3D = corpse.instantiate()
	
	new_corpse.mesh_instance_3d.mesh = mesh
	new_corpse.position = conveyor_belt.conveyor_mesh.to_local(object_slided_position)
	new_corpse.position.x += 0.05
	new_corpse.got_sliced = true
	
	conveyor_belt.conveyor_mesh.add_child(new_corpse)
