extends CharacterBody3D
class_name Player

@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var canned_food: CannedFood = $CannedFood
@onready var label: Label = $Control/Label

var has_can_in_hand: bool = false:
	set(new_value):
		has_can_in_hand = new_value
		canned_food.visible = new_value

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002

signal player_interacted_with_a_props(house_props: HouseProps.Enum)
signal player_has_finish_eating

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	if not is_inside_tree(): return
	
	check_interaction()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(_delta: float) -> void:
	display_interaction()

func check_interaction() -> void:
	if not Input.is_action_just_pressed("mouse_clic"): return
	
	if has_can_in_hand: eat_can()
	else: check_props_interaction()

func check_props_interaction() -> void:
	if not ray_cast_3d.is_colliding(): return
	
	var collider = ray_cast_3d.get_collider()
	var shape_id = ray_cast_3d.get_collider_shape()
	var owner_id = collider.shape_find_owner(shape_id)
	var shape: HouseProps = collider.shape_owner_get_owner(owner_id)
	player_interacted_with_a_props.emit(shape.object_type)

func display_interaction():
	if not ray_cast_3d.is_colliding(): 
		label.text = ""
		return
	
	#This code return error sometimes because the object is queue_free. To fix that, I should probably only desctivate it
	var collider = ray_cast_3d.get_collider()
	var shape_id = ray_cast_3d.get_collider_shape()
	var owner_id = collider.shape_find_owner(shape_id)
	var shape: HouseProps = collider.shape_owner_get_owner(owner_id)
	
	if shape == null: return
	
	var object_type: HouseProps.Enum = shape.object_type
	
	match object_type:
		HouseProps.Enum.DOOR:
			label.text = "Door"
		HouseProps.Enum.RENT_COLLECTOR:
			label.text = "Rent Collector"
		HouseProps.Enum.FRIDGE:
			label.text = "Fridge"
		HouseProps.Enum.CANNED_FOOD:
			label.text = "Canned Food"
		HouseProps.Enum.BED:
			label.text = "Bed"
		HouseProps.Enum.KNIFE:
			label.text = "Knife"

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera_3d.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera_3d.rotation.x = clampf(camera_3d.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func eat_can():
	canned_food.completion_percentage -= 25
	
	if canned_food.completion_percentage <= 0:
		has_can_in_hand = false
		player_has_finish_eating.emit()
