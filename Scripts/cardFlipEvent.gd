extends Sprite2D

var isFront = false
@onready var _aniPlayer = $AnimationPlayer

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			
			if (isFront):
				_aniPlayer.play("flip_to_Back")
				isFront = false
			else:
				_aniPlayer.play("flip_to_front")
				isFront = true
