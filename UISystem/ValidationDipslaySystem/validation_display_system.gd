extends Control
class_name ValidationDisplaySystem

@onready var color_rect: ColorRect = $ColorRect
@onready var happy_texture: TextureRect = $HappyTexture
@onready var mid_texture: TextureRect = $MidTexture
@onready var sad_texture: TextureRect = $SadTexture

@export var validate_color: Color = Color(0.0, 1.0, 0.0, 1.0)
@export var near_error_color: Color = Color(1.0, 0.569, 0.0, 1.0)
@export var error_color: Color = Color(1.0, 0.0, 0.0, 1.0)

func set_validate_state():
	color_rect.color = validate_color
	mid_texture.hide()
	sad_texture.hide()
	happy_texture.show()

func set_near_error_state():
	color_rect.color = near_error_color
	happy_texture.hide()
	sad_texture.hide()
	mid_texture.show()

func set_error_state():
	color_rect.color = error_color
	happy_texture.hide()
	mid_texture.hide()
	sad_texture.show()
