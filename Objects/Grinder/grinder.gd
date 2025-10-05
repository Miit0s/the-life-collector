extends Node3D
class_name Grinder

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var grind_zone: Area3D = $GrindZone

@export var object_grind_speed: float = 0.5

var grinder_activate: bool = false:
	set(new_value):
		grinder_activate = new_value
		if grinder_activate:
			start_grinder()
		else:
			stop_grinder()

signal object_grinded
signal grinder_use_with_no_object_in

func start_grinder():
	animation_player.play("StartRotating")
	await animation_player.animation_finished
	animation_player.play("Rotate")

func stop_grinder():
	animation_player.play("StopRotating")

func _physics_process(delta: float) -> void:
	if not grinder_activate: return
	
	if grind_zone.get_overlapping_bodies().is_empty():
		grinder_use_with_no_object_in.emit()
	
	for collider: Node3D in grind_zone.get_overlapping_bodies():
		collider.position.y -= delta * object_grind_speed

func _on_grind_zone_body_entered(body: Node3D) -> void:
	var rigid_body: RigidBody3D = body
	rigid_body.freeze = true

func _on_destroy_zone_body_entered(body: Node3D) -> void:
	body.queue_free()
	object_grinded.emit()
