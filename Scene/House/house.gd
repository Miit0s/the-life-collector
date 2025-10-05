extends Node3D

@onready var player: Player = $Player
@onready var quest_system: QuestSystem = $QuestSystem
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var canned_food: HouseProps = $Props/CannedFood

var current_step: int = 0

func _ready() -> void:
	quest_system.new_quest("Open the door")

func player_interact_with_props(house_props: HouseProps.Enum):
	match house_props:
		HouseProps.Enum.DOOR:
			open_door()
		HouseProps.Enum.RENT_COLLECTOR:
			give_money_to_collector()
		HouseProps.Enum.FRIDGE:
			open_fridge()
		HouseProps.Enum.CANNED_FOOD:
			take_canned_food()
		HouseProps.Enum.BED:
			go_to_bed()
		HouseProps.Enum.KNIFE:
			take_knife()

func open_door():
	if not current_step == HouseProps.Enum.DOOR: return
	current_step += 1
	animation_player.play("OpenDoor")
	quest_system.new_quest("Pay the rent")

func give_money_to_collector():
	if not current_step == HouseProps.Enum.RENT_COLLECTOR: return
	current_step += 1
	quest_system.new_quest("Open the fridge")
	animation_player.play_backwards("OpenDoor")

func open_fridge():
	if not current_step == HouseProps.Enum.FRIDGE: return
	current_step += 1
	animation_player.play("OpenFridge")
	quest_system.new_quest("Pick up the food")

func take_canned_food():
	if not current_step == HouseProps.Enum.CANNED_FOOD: return
	current_step += 1
	canned_food.queue_free()
	player.has_can_in_hand = true
	quest_system.new_quest("Eat the can")
	animation_player.play_backwards("OpenFridge")

func player_has_finish_eating_food():
	quest_system.new_quest("Go to bed")

func go_to_bed():
	if not current_step == HouseProps.Enum.BED: return
	current_step += 1
	lock_player()
	end_day()

func take_knife():
	if not current_step == HouseProps.Enum.KNIFE and not GlobalValue.current_day == 6: return
	current_step += 1
	print("Take knife")

func end_day():
	animation_player.play("EndDay")
	await animation_player.animation_finished
	
	GlobalValue.current_day += 1
	
	match GlobalValue.current_day:
		1:
			get_tree().change_scene_to_file("uid://lbgto5skdb7s")
		2:
			get_tree().change_scene_to_file("uid://lbgto5skdb7s")
		3:
			get_tree().change_scene_to_file("uid://lbgto5skdb7s")
		4:
			get_tree().change_scene_to_file("uid://lbgto5skdb7s")
		5:
			get_tree().change_scene_to_file("uid://lbgto5skdb7s")

func lock_player():
	player.axis_lock_linear_x = true
	player.axis_lock_linear_y = true
	player.axis_lock_linear_z = true
