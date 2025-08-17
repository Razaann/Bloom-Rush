extends CanvasLayer

var match_time := 10
var score := 0
var seeds := 0

# AUTOLOAD DIDNT NEED TO PUT AGAIN IN THE MAIN SCENE

@onready var countdown_timer = $CountdownTimer
@onready var timer_label = $TimerLabel
@onready var score_label = $ScoreLabel
@onready var seeds_label = $SeedsLabel

func _ready():
	countdown_timer.wait_time = 1.0
	countdown_timer.start()
	update_ui()

func _on_countdown_timer_timeout():
	if match_time > 0:
		match_time -= 1
		update_ui()
	else:
		countdown_timer.stop()
		game_over()

func add_score(amount: int):
	score += amount
	update_ui()

func add_seeds(amount: int):
	seeds += amount
	update_ui()

func use_seed() -> bool:
	if seeds > 0:
		seeds -= 1
		update_ui()
		return true
	return false

func add_time(amount: int):
	match_time += amount
	update_ui()

func update_ui():
	timer_label.text = "%s" % match_time
	score_label.text = "Score: %s" % score
	seeds_label.text = "Seeds: %s" % seeds

func game_over():
	print("Game Over! Final score: %s" % score)
