extends Node

var percorsi : Array[Path3D] = []
@export var NPCs : Array[CharacterBody3D]
@export var speed : float = 3

func _ready() -> void:
	for n in get_children():
		if n is Path3D:
			percorsi.append(n)
	for p in percorsi:
		var follow := PathFollow3D.new()
		var duration = p.curve.get_baked_length() / speed
		p.add_child(follow)
		var npc = NPCs.pick_random()
		#npc.is_walking = true
		follow.add_child(npc)
		start_walking(follow, duration)

func start_walking(path:PathFollow3D, duration:float=4):
	var tween := get_tree().create_tween().set_loops()
	tween.tween_property(path, "progress_ratio", 1, duration)
	tween.tween_property(path, "progress_ratio", 0, duration)
