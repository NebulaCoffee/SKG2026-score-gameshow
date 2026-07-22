extends Node3D

# Variables
@export var current_score: int
@export var speed: int
var start : bool

# Nodes
@onready var character_ani: AnimatedSprite3D = $CharacterBody3D/CharacterAni
@onready var score: Label3D = $CharacterBody3D/Score
@onready var timer: Timer = $Timer
@onready var character_body_3d: CharacterBody3D = $CharacterBody3D

func _physics_process(delta: float) -> void:
	if start == true:
		character_body_3d.velocity.x = 1 * speed
		character_body_3d.move_and_slide()

func _ready() -> void:
	start = false
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
