extends Node

# Variables
var scores: = [["Rookie 1",100],["Boom 99",250],["Catchup 25",500],["Rider 71",1000],["Nemesis Alpha",2000]]

# Nodes
@onready var scorer_container: VBoxContainer = $CanvasLayer/HBoxContainer/ScorerContainer
@onready var score_container: VBoxContainer = $CanvasLayer/HBoxContainer/ScoreContainer
@onready var text: RichTextLabel = $CanvasLayer/Bubble/Text


func _ready() -> void:
	$CanvasLayer/PlayAgain.grab_focus()
	AudioManager.update_music_speed(1)
	var count = 5
	var sindex = 5
	if scores[4][1] < Globals.current_score:
		scores[4][1] = Globals.current_score + 100
	scores.append(["Runner 42",Globals.current_score])
	scores.sort_custom(sort_ascending)
	for i in scores:
		scorer_container.get_child(count).text = str(i[0])
		score_container.get_child(count).text = str(i[1])
		if i[0] == "Runner 42":
			scorer_container.get_child(count).add_theme_color_override("default_color", Color(0.929, 0.0, 0.657, 1.0))
			score_container.get_child(count).add_theme_color_override("default_color", Color(0.929, 0.0, 0.657, 1.0))
		count -= 1
	if Globals.current_score > 100:
		text.text = "Well, you beat the rookie at least!"
	if Globals.current_score > 250:
		text.text = "Not bad! But you're still doing terribly!"
	if Globals.current_score > 500:
		text.text = "You caught up to Catchup 25!"
	if Globals.current_score > 1000:
		text.text = "Nemesis Alpha better watch out! Actually they shouldn't, they've won every game they've played. You really should give up now."
	if Globals.current_score > 2000:
		text.text = "Oh, nice score! Keep chasing and maybe one day you might beat Nemesis Alpha! (You won't)"
	
func sort_ascending(a,b):
	if a[1] < b[1]:
		return true
	return false


func _on_play_again_pressed() -> void:
	Globals.current_score = 0
	get_tree().change_scene_to_file("res://Scenes/LevelChunks/start.tscn")
