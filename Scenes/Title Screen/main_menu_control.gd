extends Control

@onready var music_slider = $AudioSettingsVBoxContainer/MusicSlider
@onready var sfx_slider = $AudioSettingsVBoxContainer/SFXSlider
@onready var sfx_stream_player = get_node("/root/TitleSubviewport/SFXStreamPlayer")

var sfx_pop = load("res://Assets/Audio/SFX/pop-rimshot.mp3")

const music_bus = 1
const sfx_bus = 2

func _ready():
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	sfx_slider.drag_ended.connect(_on_slider_change_complete)

func _on_slider_change_complete(value: float):
	sfx_stream_player.stream = sfx_pop
	sfx_stream_player.play()

func _on_music_slider_changed(value: float):
	_set_bus_volume(
		music_bus,
		value
	)

func _on_sfx_slider_changed(value: float):
	_set_bus_volume(
		sfx_bus,
		value
	)

func _set_bus_volume(bus: int, value: float):
	if value <= 0:
		AudioServer.set_bus_volume_db(bus, -80)
	else:
		AudioServer.set_bus_volume_db(
			bus,
			linear_to_db(value / 100.0)
		)
		
		
		
