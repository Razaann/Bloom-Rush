extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	UI.hide_ui()
	$Music.play()


func _on_button_pressed():
	UI.reset()  # reset points
	get_tree().change_scene_to_file("res://Scenes/level.tscn")  # change to your main game scene
