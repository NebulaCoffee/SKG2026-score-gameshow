extends Area3D

const test_chunk = preload("res://Scenes/LevelChunks/test_chunk.tscn")
var next_chunk: Node3D
var last_chunk: Node3D
const CHUNK_LENGTH := 180.0

func _ready() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	next_chunk = test_chunk.instantiate()

	if last_chunk == null:
		next_chunk.position = Vector3(CHUNK_LENGTH, 0, 0)
		last_chunk = next_chunk
	else:
		next_chunk.position = last_chunk.position + Vector3(CHUNK_LENGTH, 0, 0)
		last_chunk = next_chunk
	get_tree().current_scene.add_child(next_chunk)
	await get_tree().process_frame

	for child in next_chunk.get_children():
		if child is Area3D:
			child.body_entered.connect(_on_body_entered)
