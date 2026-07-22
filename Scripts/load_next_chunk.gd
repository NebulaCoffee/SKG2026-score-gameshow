extends Area3D

const test_chunk = preload("res://Scenes/LevelChunks/test_chunk.tscn")
var next_chunk


func _ready() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	next_chunk = test_chunk.instantiate()
	get_parent().add_child(next_chunk)
	next_chunk.position = Vector3(170,0,0)
	print(next_chunk.get_child(0).global_position)
