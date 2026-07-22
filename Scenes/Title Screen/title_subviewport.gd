extends Node3D

@onready var titles = [
	$Chase,
	$That,
	$Score
]

@onready var main_menu_control = $CanvasLayer/MainMenuControl
@onready var splash_sprite = $SplashSprite
@onready var dev_logo_sprite = $DevLogoSprite

@onready var music_stream_player = $MusicStreamPlayer
@onready var sfx_stream_player = $SFXStreamPlayer

# Load SFX.
var sfx_audience_cheer = load("res://Assets/Audio/SFX/audience-cheer.mp3")
var sfx_audience_chatter = load("res://Assets/Audio/SFX/crowd-chatter.mp3")
var sfx_pop = load("res://Assets/Audio/SFX/pop-rimshot.mp3")
var music_menu = load("res://Assets/Audio/Music/menu_music.mp3")

# Set where we want the title parts to end up.
var current_title_part := 0

var target_positions = [
	Vector3(-0.51, 0.2, -0.82),Vector3(-0.04, 0.2, -0.82),Vector3(0.42, 0.2, -0.82)
]

var target_rotations = [
	Vector3(0,0,0),	Vector3(0,0,26.0),	Vector3(0,0,0),
]

# The speed with which the title parts zoom to the viewport.
var speed := 24.0

var time := 0.0
var start_title_animation := false
var idle_animation_begun := false

func _ready():
	for title in titles:
		title.position = Vector3(0, 0, -20)
		title.visible = false
	sfx_stream_player.stream = sfx_audience_chatter
	sfx_stream_player.play()
	await fade_out_and_remove(splash_sprite)
	await fade_in(dev_logo_sprite)
	await get_tree().create_timer(3).timeout
	await fade_out_and_remove(dev_logo_sprite)
	start_sequence()

func start_sequence():
	sfx_stream_player.stop()
	sfx_stream_player.stream = sfx_audience_cheer
	music_stream_player.play()
	await get_tree().create_timer(2).timeout
	sfx_stream_player.play()
	await get_tree().create_timer(5).timeout
	start_title_animation = true

func fade_out_and_remove(sprite3D: Sprite3D):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite3D, "modulate:a", 0.0, 3.0)
	tween.tween_callback(sprite3D.queue_free)
	await tween.finished
	
func fade_in(sprite3D: Sprite3D):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite3D, "modulate:a", 1.0, 0.5)
	await tween.finished
	
func _process(delta):
	if not start_title_animation:
		return
	
	time += delta

	# Bring words in one at a time.
	if current_title_part < titles.size():
		var title = titles[current_title_part]
		var target_position = target_positions[current_title_part]
		var target_rotation = target_rotations[current_title_part]

		if not title.visible:
			title.visible = true
		
		title.position = title.position.move_toward(
			target_position,
			delta * speed
		)
		
		title.rotation = title.rotation.move_toward(
			target_rotation,
			delta * speed
		)

		if title.position.distance_to(target_position) < 0.05 && title.rotation.distance_to(target_rotation) < 0.05:
			current_title_part += 1
			sfx_stream_player.stream = sfx_pop
			sfx_stream_player.play()

	# Idle animation once everything has arrived.
	else:
		if not idle_animation_begun:
			music_stream_player.stream = music_menu
			music_stream_player.play()
			idle_animation_begun = true
			main_menu_control.visible = true
		
		for i in titles.size():
			var title = titles[i]
			var target_position = target_positions[i]
			var target_rotation = target_rotations[i]

			var offset = i * 0.4

			title.position.y = target_position.y + sin(time * 1.2 + offset) * 0.03

			title.rotation_degrees.z = sin(time * 0.8 + offset) * 0.1 + target_rotation.z

			var scale_amount = 1.0 + sin(time * 1.5 + offset) * 0.02

			title.scale = Vector3.ONE * scale_amount


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
