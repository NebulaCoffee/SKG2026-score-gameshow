extends Node3D

@onready var music_level = load("res://Assets/Audio/Music/level_music.mp3")
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.music_player.stream = music_level
	AudioManager.music_player.play()

func _process(delta: float) -> void:
	AudioManager.update_music_speed(player.speed)
