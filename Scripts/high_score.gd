extends Node3D

# Variables
@export var current_score: int
@export var speed: int
var yspeed : int
var start : bool

# Nodes
@onready var character_ani: AnimatedSprite3D = $CharacterBody3D/CharacterAni
@onready var score: Label3D = $CharacterBody3D/Score
@onready var timer: Timer = $Timer
@onready var character_body_3d: CharacterBody3D = $CharacterBody3D

# Signals
signal score_emit(emitted_score: int)

func _physics_process(delta: float) -> void:
	if start == true:
		character_body_3d.velocity.x = 1 * speed
		character_body_3d.velocity.y = 1 * yspeed
		character_body_3d.move_and_slide()

func _ready() -> void:
	start = false
	_switch_dir("up")
	update_score(current_score)

func update_score(newscore : int) ->void:
	score.text = str(newscore)

func _process(delta: float) -> void:
	await get_tree().create_timer(1).timeout
	start = true

func _on_timer_timeout() -> void:
	current_score += 1
	update_score(current_score)
	timer.start()
	if character_body_3d.global_position.y >= 100:
		_switch_dir("down")
	if character_body_3d.global_position.y <= 0:
		_switch_dir("up")

func _switch_dir(dir: String)->void:
	match dir:
		"up":
			yspeed = 10
		"down":
			yspeed = -10

func emit_score()->void:
	score_emit.emit(current_score)

func load_end_scene()->void:
	print("GAME OVER!")
	get_tree().change_scene_to_file("res://Scenes/High score screen/high_score_screen.tscn")


func _on_area_3d_area_entered(area: Area3D) -> void:
	load_end_scene()
