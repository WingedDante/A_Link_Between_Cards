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
		if(Global.card_to_compare_1.cardName == Global.card_to_compare_2.cardName):
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
	var cardMatch = 1
	var random = 0
	for w in width :
		for h in height : 
			var sprite = ""
			
			if cardMatch == 1 :
				var rng = RandomNumberGenerator.new()
				random = rng.randi_range(1, 7)
				cardMatch = 2
			else :
				cardMatch = 1
			var newCard = card_scene.instantiate()
			var face = newCard.get_node("Front")
			if random == 1 :
				face.texture = load("res://Scenes/Card_Images/Beedle.png")
				newCard.cardName = "Beedle"
			elif random == 2 :
				face.texture = load("res://Scenes/Card_Images/Agahnim.png")
				newCard.cardName = "Agahnim"
			elif random == 3 :
				face.texture = load("res://Scenes/Card_Images/Agitha.png")
				newCard.cardName = "Agitha"
			elif random == 4 :
				face.texture = load("res://Scenes/Card_Images/Alfonzo.png")
				newCard.cardName = "Alfonzo"
			elif random == 5 :
				face.texture = load("res://Scenes/Card_Images/Aryll.png")
				newCard.cardName = "Aryll"
			elif random == 6 :
				face.texture = load("res://Scenes/Card_Images/BeastGanon.png")
				newCard.cardName = "BeastGanon"
			elif random == 7 :
				face.texture = load("res://Scenes/Card_Images/Cucco.png")
				newCard.cardName = "Cucco"
			#newCard.position.x = (1745.0/width) * (w) + (1745.0/width)/2
			#newCard.position.y = (1080.0/height) * (h) + (1080.0/height)/2
			newCard.game_scene = self
			card_list.append(newCard)
			add_child(newCard)
	card_list.shuffle()
	var i = 0
	for w in width :
		for h in height : 
			card_list[i].position.x = (1745.0/width) * (w) + (1745.0/width)/2
			card_list[i].position.y = (1080.0/height) * (h) + (1080.0/height)/2
			i += 1
	for card in card_list :
		card.get_node("AnimationPlayer").play("flip_to_front")
	
	
	game_timer.start()

func _on_game_timer_timeout():
	time_passed += 1 # Replace with function body.
	
func game_over():
	game_timer.stop()
	Global.game_over = true
