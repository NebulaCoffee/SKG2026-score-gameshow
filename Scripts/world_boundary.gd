extends Area3D

@onready var player: Node3D = $"../Player"

func _on_area_entered(area: Area3D) -> void:
	print(area)
	get_tree().change_scene_to_file("res://Scenes/High score screen/high_score_screen.tscn")
