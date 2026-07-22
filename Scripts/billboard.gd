extends Node3D

@onready var billboard_floor: MeshInstance3D = $BillboardFloor
const MAT_FOL = "res://Assets/3D/Textures/billboard_mats/"

func _ready() -> void:
	match randi_range(0,3):
		0:load_texture(MAT_FOL + "mecha.tres")
		1:load_texture(MAT_FOL + "nebula.tres")
		2:load_texture(MAT_FOL + "skull.tres")
		3:load_texture(MAT_FOL + "soilent.tres")

func load_texture(location : String)->void:
	billboard_floor.material_override = load(location)
