extends Node3D

@export var score : int
@onready var score_text: Label3D = $ScoreText

func _ready() -> void:
	score_text.text = str(score)
	if score < 50:
		score_text.modulate = "33ffff"
	elif score < 100:
		score_text.modulate = "dfd70c"
	elif  score < 500:
		score_text.modulate = "df1a0c"
	else:
		score_text.modulate = "d1009b"

func _on_area_3d_area_entered(area: Area3D) -> void:
	Globals.current_score += score
	queue_free()
