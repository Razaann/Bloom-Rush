extends CanvasLayer

@export var start_time := 10   # starting countdown
@export var time_bonus := 1    # extra seconds when planting

var time_left : int
var score : int = 0
var seeds_left : int = 0   # start with 0 seeds

@onready var timer_label = $VBoxContainer/TimerLabel
@onready var score_label = $VBoxContainer/ScoreLabel
@onready var seeds_label = $VBoxContainer/SeedsLabel
@onready var countdown_timer = $CountdownTimer

func _ready():
	time_left = start_time
	update_ui()
	countdown_timer.start()

# runs every second
func _on_CountdownTimer_timeout():
	time_left -= 1
	if time_left <= 0:
		time_left = 0
		game_over()
	update_ui()

func add_score():
	score += 1
	update_ui()

func add_time():
	time_left += time_bonus
	update_ui()

func use_seed() -> bool:
	# returns true if planting is possible
	if seeds_left > 0:
		seeds_left -= 1
		update_ui()
		return true
	return false

func add_seed(amount: int = 1):
	seeds_left += amount
	update_ui()

func update_ui():
	timer_label.text = "Time: %d" % time_left
	score_label.text = "Score: %d" % score
	seeds_label.text = "Seeds: %d" % seeds_left

func game_over():
	get_tree().paused = true
	print("Game Over!")
