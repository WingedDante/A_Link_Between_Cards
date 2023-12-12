class_name Card extends Sprite2D

@export var flipLocked = false
var isFront = false
@onready var _aniPlayer = $AnimationPlayer
@export var game_scene : Game
@onready var _Highlight = $Highlight
@export var cardName = ""

func _input(event):
	if (!Global.game_over) :
		if not Global.card_flipping :
			if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
				if get_rect().has_point(to_local(event.position)) && not flipLocked && not isFront :
					Global.card_flipping = true
					isFront = true
					_aniPlayer.play("flip_to_front")
					


func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "flip_to_front"):
		Global.card_flipping = false
		if (Global.card_to_compare_1 == null) :
			Global.card_to_compare_1 = self
		else :
			Global.card_to_compare_2 = self
	if (anim_name == "flip_to_Back"):
		Global.card_flipping = false
	game_scene.process_cards_flipped()
func reset():
	isFront= false
	_aniPlayer.play("flip_to_Back")
	


func _on_area_2d_mouse_entered():
	_Highlight.visible = true
	

func _on_area_2d_mouse_exited():
	_Highlight.visible = false 
