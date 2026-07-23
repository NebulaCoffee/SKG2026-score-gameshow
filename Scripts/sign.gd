extends Node3D

@onready var building: MeshInstance3D = $BuildingAndSign1
@onready var sign: MeshInstance3D = $BuildingAndSign1/Sign
const MAT_FOL = "res://Assets/3D/Textures/sign_mats/"
const DEFAULT_MAT_FOL = "res://Assets/3D/Textures/sign_mats/"

func _ready() -> void:
	var new_building_material := StandardMaterial3D.new()
	match randi_range(0,0):
		0:load_texture(MAT_FOL + "familiarsnacks.tres")
	match randi_range(0,3):
		0:new_building_material.albedo_color = Color("#d53c6a")
		1:new_building_material.albedo_color = Color("#534ed9")
		2:new_building_material.albedo_color = Color("#22c278")
		3:new_building_material.albedo_color = Color("#924fdc")
	building.material_override = new_building_material

func load_texture(location : String)->void:
	sign.material_override = load(location)
