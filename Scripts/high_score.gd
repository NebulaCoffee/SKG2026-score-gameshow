extends Node2D

# Variables

# Nodes
@onready var character_ani: AnimatedSprite2D = $CharacterAni
@onready var score: RichTextLabel = $Score

func _ready() -> void:
	update_score(9000)

func update_score(newscore : int) ->void:
	score.text = str(newscore)
