extends Node3D

@export var hold_mode: bool = false
@export var clic_cooldown: float = 0.1

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_activated: bool = false:
	set(activated):
		is_activated = activated
		@warning_ignore("standalone_ternary")
		animation_player.play("push") if activated else animation_player.play("release")

signal button_clicked
signal start_holding_button
signal stop_holding_button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hold_mode:
		if Input.is_action_pressed("mouse_clic"):
			is_activated = true
			start_holding_button.emit()
		else:
			is_activated = false
			stop_holding_button.emit()
	else:
		if is_activated: return
		if not Input.is_action_just_pressed("mouse_clic"): return
		
		clic_one_time()

func clic_one_time():
	is_activated = true
	button_clicked.emit()
	await get_tree().create_timer(clic_cooldown).timeout
	is_activated = false
