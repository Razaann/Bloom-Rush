extends Control

@onready var highscore_label = $HighscoreLabel
@onready var score_label = $ScoreLabel
@onready var restart_button = $RestartButton

func _ready():
	UI.hide_ui()
	
	# update labels from UI
	score_label.text = "Your Score: %s" % UI.score
	
	# update highscore
	if UI.score > UI.highscore:
		UI.highscore = UI.score
	
	highscore_label.text = "Highscore: %s" % UI.highscore
	
	restart_button.pressed.connect(_on_restart_button_pressed)

func _on_restart_button_pressed():
	UI.reset()  # reset points
	get_tree().change_scene_to_file("res://Scenes/level.tscn")  # change to your main game scene
