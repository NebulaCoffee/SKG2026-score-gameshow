extends Node

# Variables
var scores: = [["Rookie 1",100],["Boom 99",250],["Catchup 25",500],["Rider 71",1000],["Nemesis Alpha",2000]]

# Nodes
@onready var scorer_container: VBoxContainer = $CanvasLayer/HBoxContainer/ScorerContainer
@onready var score_container: VBoxContainer = $CanvasLayer/HBoxContainer/ScoreContainer


func _ready() -> void:
	var count = 5
	var sindex = 5
	if scores[4][1] < Globals.current_score:
		scores[4][1] = Globals.current_score + 100
		
	scores.append(["Runner 42",Globals.current_score])
	scores.sort_custom(sort_ascending)
	for i in scores:
		scorer_container.get_child(count).text = str(i[0])
		score_container.get_child(count).text = str(i[1])
		count -= 1
	
func sort_ascending(a,b):
	if a[1] < b[1]:
		return true
	return false


func _on_play_again_pressed() -> void:
	Globals.current_score = 0
	get_tree().change_scene_to_file("res://Scenes/LevelChunks/start.tscn")
