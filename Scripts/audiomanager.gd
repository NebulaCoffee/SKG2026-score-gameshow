extends Node

@onready var music_player := AudioStreamPlayer.new()
@onready var sfx_player := AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	add_child(sfx_player)

	music_player.bus = "Music"
	sfx_player.bus = "SFX"

func update_music_speed(player_speed: int):
	music_player.pitch_scale = clamp(0.5 + player_speed * 0.005, 1.0, 2.0)
