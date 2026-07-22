extends Area3D

const test_chunk = preload("res://Scenes/LevelChunks/test_chunk.tscn")
var next_chunk

func _on_body_entered(body: Node3D) -> void:
	next_chunk = test_chunk.instantiate()
	add_child(next_chunk)
	#next_chunk.position = Vector3(50,0,0)
