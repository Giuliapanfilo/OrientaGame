@tool
extends Node3D
class_name SceneSwapper

@export var target_scene : PackedScene
@onready var freccia := $Freccia
@export_enum("up:45", "down:125") var direzione: 
	set(v):
		direzione = v
		if freccia:
			freccia.rotation_degrees.x = direzione
var teleporting = false
#todo animare sprite freccina


func _on_area_freccia_body_entered(body: Node3D) -> void:
	if body is Player:
		freccia.visible = true


func _on_area_freccia_body_exited(body: Node3D) -> void:
	if body is Player:
		freccia.visible = false


func _on_area_teletrasporto_body_entered(body: Node3D) -> void:
	if body is Player and not teleporting:
		teleporting = true
		SceneLoader.swap(target_scene)
