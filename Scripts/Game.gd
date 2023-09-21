extends Node2D

const number_of_cards: int = 15 
const width : int = 5
const height : int = 3

var card_scene = preload("res://card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in number_of_cards:
		var newCard = card_scene.instantiate()
		#if i < 3:
			#newCard.position = Vector2((i* newCard.texture.get_width()) + newCard.texture.get_width()/2, newCard.texture.get_height()/2)
		#newCard.position = Vector2((DisplayServer.window_get_size().x / 3) * (i%3) + newCard.texture.get_width()/2, DisplayServer.window_get_size().y/2 * (i%2))
		#newCard.position.x = newCard.texture.get_width()/2
		#newCard.position.y = newCard.texture.get_height()/2
		newCard.position.x = (DisplayServer.window_get_size().x/width) * (i%width) + (DisplayServer.window_get_size().x/width)/2
		newCard.position.y = (DisplayServer.window_get_size().y/height) * (i%height) + (DisplayServer.window_get_size().y/height)/2
		
		#else:
			#newCard.position = Vector2((i-3)* newCard.texture.get_width() + newCard.texture.get_width()/2, newCard.texture.get_height() * 1.5) 
		add_child(newCard)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
