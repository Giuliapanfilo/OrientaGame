# res://ui/ItemPreview.gd
extends Control
class_name  ItemPreview

@export var rotate_speed := 0.15  # radianti al secondo

@onready var _subvp     = $SubViewportContainer/SubViewport
@onready var _mesh_inst = $SubViewportContainer/SubViewport/Node3D/MeshInstance3D

@export var material_silhouette : StandardMaterial3D
var free_player : Callable = func(any):
		hide()
		SceneLoader.player.can_move = true
		SceneLoader.player.can_animate = true
	
#@onready var _tex_rect  = $TextureRect

func show_item(res : Collectible, silhouette:bool=false):
	_mesh_inst.mesh = res.mesh
	_mesh_inst.material_override = material_silhouette if silhouette else null

	show()
	var p :Player= SceneLoader.player
	p.can_move = false
	p.can_animate = false
	get_tree().create_timer(5).timeout.connect(free_player)


	
func _process(delta):
	# ruota intorno all'asse Y
	_mesh_inst.rotate_y(delta * rotate_speed * TAU)

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(free_player)
