@tool
extends Node3D
class_name SceneSwapper

#@export var target_scene : PackedScene
@export_file("*.tscn") var target_scene_path : String 
@export var at : StringName
@onready var freccia := $Freccia
@export_enum("up:110", "down:70") var direzione = 70: 
	set(v):
		direzione = v
		if freccia:
			freccia.rotation_degrees.x = direzione
var can_teleport = true
#todo animare sprite freccina

func _ready() -> void:
	freccia.rotation_degrees.x = direzione


func _on_area_freccia_body_entered(body: Node3D) -> void:
	if body is Player:
		can_teleport = true
		freccia.visible = true


func _on_area_freccia_body_exited(body: Node3D) -> void:
	if body is Player:
		freccia.visible = false


func _on_area_teletrasporto_body_entered(body: Node3D) -> void:
	if body is Player and can_teleport:
		can_teleport = false
		SceneLoader.swap(load(target_scene_path), at)
