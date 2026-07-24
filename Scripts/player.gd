extends Node3D

# Nodes
@onready var player_ani: AnimatedSprite3D = $PlayerChar/PlayerAni
@onready var player_char: CharacterBody3D = $PlayerChar
@onready var player_col: CollisionShape3D = $PlayerChar/PlayerCol
@onready var camera_3d: Camera3D = $PlayerChar/PlayerCam/Camera3D
@onready var groundhit: RayCast3D = $PlayerChar/GroundHit
@onready var side_hit: RayCast3D = $PlayerChar/SideHit
@onready var jump_timer: Timer = $JumpTimer
@onready var speed_text: RichTextLabel = $PlayerChar/PlayerCam/Camera3D/CanvasLayer/Speed

# Audio
@onready var sfx_stream_player: AudioStreamPlayer = AudioManager.sfx_player
@onready var sfx_jump = load("res://Assets/Audio/SFX/jump.mp3")

# Variables
@export var speed: int # Determines the current speed of the character
@export var jumpspeed : int # Determines jump speed
@export var fallspeed : int
var start : bool
var defult_col: Vector3
var col_pos: Vector3
var jumping: bool
var running: bool
var air : bool
var double_jump : int

func _ready() -> void:
	air == false
	start = true
	jumping = false
	double_jump = 2
	defult_col = player_col.shape.size
	col_pos = player_col.position

func _physics_process(delta: float) -> void:
	while start == true:
		_set_ani("idle",0)
		await get_tree().create_timer(1).timeout
		_set_ani("running",1)
		start = false
		running = true
		air = true
	speed += 0.1
	speed_text.text = str(speed)
	player_ani.speed_scale += (speed/100)
	if player_ani.speed_scale > 25:
		player_ani.speed_scale = 25
	if Input.is_action_just_pressed("ui_right") && running == true:
		_set_ani("running",5)
	if Input.is_action_just_pressed("ui_left") && running == true:
		_set_ani("running",-1)
	if Input.is_action_just_pressed("jump") && double_jump > 0:
		jump()
		sfx_stream_player.stream = sfx_jump
		sfx_stream_player.play()
	if Input.is_action_just_pressed("slide"):
		slide()
	if groundhit.is_colliding() == true:
		double_jump = 2
		air = false
	if side_hit.is_colliding() == true:
		speed -= 10
		
	if air == true:
		player_char.velocity += (player_char.get_gravity()*fallspeed) * delta
		if Input.is_action_just_pressed("jump") && groundhit.is_colliding() == true:
			jump()
	if running == true:
		player_char.velocity.x = 1 * speed
		player_char.velocity += (player_char.get_gravity()) * delta
	if jumping == true:
		player_char.velocity.y = jumpspeed
	
	player_char.move_and_slide()

# Function for changing the player speed and current animation
func _set_ani(ani : String, spd : int)->void:
	speed += spd
	player_ani.animation = ani
	player_ani.play()

# Run this function when the player character slides. It should do the skid animation and reduce the
# collision box size.
func slide()->void:
	player_col.shape.size.y = 8
	player_col.position.y = -8
	fallspeed = 4
	_set_ani("skid",2)
	jumping = false
	await player_ani.animation_finished
	_set_ani("skid_loop",-1)
	await get_tree().create_timer(1).timeout
	normal()
	

# Run this function when the player character jumps. It should move them upwards.
func jump()->void:
	air = true
	jumping = true
	double_jump -= 1
	player_col.shape.size = Vector3(6,12,1)
	_set_ani("jump", 5)
	#await player_ani.animation_finished
	#_set_ani("jump_loop",0)
	jump_timer.start()
	
func normal() -> void:
	player_col.shape.size = defult_col
	player_col.position = col_pos
	fallspeed = 2
	
	jumping = false
	running = true
	_set_ani("running",0)

func stop() -> void:
	player_col.shape.size = defult_col
	speed = 0
	_set_ani("idle",0)

func falling()-> void:
	_set_ani("falling",0)
	#player_ani.rotation.z =-45


func _on_jump_timer_timeout() -> void:
	air = true
	normal()
