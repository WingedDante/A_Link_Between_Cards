class_name Game extends Node2D

const number_of_cards: int = 15 
const width : int = 5
const height : int = 3

var card_scene = preload("res://card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in number_of_cards:
		var newCard = card_scene.instantiate()
		newCard.position.x = (DisplayServer.window_get_size().x/width) * (i%width) + (DisplayServer.window_get_size().x/width)/2
		newCard.position.y = (DisplayServer.window_get_size().y/height) * (i%height) + (DisplayServer.window_get_size().y/height)/2
		newCard.game_scene = self
		add_child(newCard)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.card_to_compare_1 and Global.card_to_compare_2 ):
		if(Global.card_to_compare_1.texture.resource_name == Global.card_to_compare_2.texture.resource_name):
			print("2 CARDS FLIPPED match")
		else :
			print("2 CARDS FLIPPED NO MATCH")
			Global.card_to_compare_1.reset()
			Global.card_to_compare_2.reset()
		Global.card_to_compare_1 = null
		Global.card_to_compare_2 = null
