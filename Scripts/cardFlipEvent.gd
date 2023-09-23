class_name Card extends Sprite2D

@export var flipLocked = false;
var isFront = false
@onready var _aniPlayer = $AnimationPlayer
@export var game_scene : Game

func _input(event):
	if not Global.card_flipping :
		if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)) && not flipLocked:
				if (isFront):
					_aniPlayer.play("flip_to_Back")
					Global.card_flipping = true
					isFront = false
				else:
					_aniPlayer.play("flip_to_front")
					Global.card_flipping = true
					isFront = true


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "flip_to_front"):
		Global.card_flipping = false
		if (!Global.card_to_compare_1 ) :
			Global.card_to_compare_1 = self
		else  :
			Global.card_to_compare_2 = self
	if (anim_name == "flip_to_Back"):
		Global.card_flipping = false
		
func reset():
	_aniPlayer.play("flip_to_Back")
	isFront= false
