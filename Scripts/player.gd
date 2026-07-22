extends Node3D

# Nodes
@onready var player_ani: AnimatedSprite3D = $PlayerChar/PlayerAni
@onready var player_char: CharacterBody3D = $PlayerChar
@onready var player_col: CollisionShape3D = $PlayerChar/PlayerCol
@onready var camera_3d: Camera3D = $PlayerChar/SpringArm3D/Camera3D

# Variables
@export var speed: int # Determines the current speed of the character
@export var jumpspeed : int # Determines jump speed
var defult_col: Vector3
var jumping: bool
var running: bool

func _ready() -> void:
	jumping = false
	defult_col = player_col.shape.size

func _physics_process(delta: float) -> void:
	player_char.velocity += player_char.get_gravity() * delta
	if running == true:
		player_char.velocity.x = 1 * speed
	
	player_char.move_and_slide()

func _process(delta: float) -> void:
	while running == false:
		_set_ani("idle",0)
		await get_tree().create_timer(1).timeout
		_set_ani("running",1)
		running = true
	#print(camera_3d.position)
	
	speed += 0.1
	player_ani.speed_scale += (speed/100)
	if player_ani.speed_scale > 50:
		player_ani.speed_scale = 50
	if Input.is_action_just_pressed("ui_right"):
		_set_ani("running",5)
	if Input.is_action_just_pressed("ui_left"):
		_set_ani("running",-1)
	if Input.is_action_just_pressed("jump") && jumping == false:
		jump()
	if Input.is_action_just_pressed("slide"):
		slide()

# Function for changing the player speed and current animation
func _set_ani(ani : String, spd : int)->void:
	speed += spd
	player_ani.animation = ani
	player_ani.play()

# Run this function when the player character slides. It should do the skid animation and reduce the
# collision box size.
func slide()->void:
	player_col.shape.size.y = 8
	player_col.position.y = 8
	_set_ani("skid",2)
	print(player_col.shape.size.y)
	await player_ani.animation_finished
	_set_ani("skid_loop",-1)
	await get_tree().create_timer(1).timeout
	normal()
	

# Run this function when the player character jumps. It should move them upwards.
func jump()->void:
	jumping = true
	player_char.velocity.y = jumpspeed
	player_col.shape.size = Vector3(6,12,0)
	_set_ani("jump", 5)
	await player_ani.animation_finished
	_set_ani("jump_loop",0)
	await get_tree().create_timer(0.1).timeout
	normal()
	
func normal() -> void:
	player_col.shape.size = defult_col
	jumping = false
	_set_ani("running",0)

func stop() -> void:
	player_col.shape.size = defult_col
	speed = 0
	_set_ani("idle",0)
