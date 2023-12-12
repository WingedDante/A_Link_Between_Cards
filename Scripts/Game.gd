class_name Game extends Node2D

@onready var score_label = $GridContainer/ScoreLabel
@onready var time_label = $GridContainer/TimeLabel
@onready var game_timer = $GameTimer

const width : int = 9
const height : int = 4

var score : int = 0
var time_limit : int = 60
var time_passed : int = 0
var matches : int = 0

var card_scene = preload("res://card.tscn")
var card_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	game_setup()
	start_game()
	
func _process(delta):
	if (!Global.game_over):
		if (time_limit - time_passed <=0 or matches >= (width * height)/2):
			game_over()
		time_label.text = str(time_limit - time_passed, "s")

func process_cards_flipped():
	if (Global.card_to_compare_1 and Global.card_to_compare_2 ):
		if(Global.card_to_compare_1.texture.resource_name == Global.card_to_compare_2.texture.resource_name):
			print("2 CARDS FLIPPED match")
			score += 1
			matches += 1
		else :
			print("2 CARDS FLIPPED NO MATCH")
			Global.card_to_compare_1.reset()
			Global.card_to_compare_2.reset()
			
		Global.card_to_compare_1 = null
		Global.card_to_compare_2 = null
		score_label.text = str("Score : ", score)

func _on_button_pressed():
	game_setup()
	start_game()

func game_setup(): 
	score = 0
	time_passed = 0
	matches = 0
	score_label.text = str("Score : ", score)
	Global.card_to_compare_1 = null
	Global.card_to_compare_2 = null
	Global.game_over = false
	for card in card_list :
		card.queue_free()
	card_list = []
	
func start_game():
	for w in width :
		for h in height : 
			var newCard = card_scene.instantiate()
			newCard.position.x = (1745.0/width) * (w) + (1745.0/width)/2
			newCard.position.y = (1080.0/height) * (h) + (1080.0/height)/2
			newCard.game_scene = self
			card_list.append(newCard)
			add_child(newCard)
	game_timer.start()

func _on_game_timer_timeout():
	time_passed += 1 # Replace with function body.
	
func game_over():
	game_timer.stop()
	Global.game_over = true
