extends Node2D

# Variables
@export var speed: int # Determines the current speed of the character

# Nodes
@onready var player_ani: AnimatedSprite2D = $PlayerAni
@onready var player_char: CharacterBody2D = $PlayerChar
@onready var player_col: CollisionShape2D = $PlayerChar/PlayerCol

func _ready() -> void:
	speed = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		_set_ani("running",1)
	if Input.is_action_just_pressed("ui_left"):
		_set_ani("slowing",-1)
	if Input.is_action_just_pressed("ui_up"):
		_set_ani("jump",0)
	if Input.is_action_just_pressed("ui_down"):
		_set_ani("skid",0)

# Function for changing the player speed and current animation
func _set_ani(ani : String, spd : int)->void:
	speed += spd
	print(speed)
	player_ani.animation = ani
