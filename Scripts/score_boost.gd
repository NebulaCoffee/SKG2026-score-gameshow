extends Node3D

var score : int
@onready var score_text: Label3D = $ScoreText

func _ready() -> void:
	pass

func _on_area_3d_area_entered(area: Area3D) -> void:
	Globals.current_score += score
