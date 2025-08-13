extends Node

var percorsi: Array[Path3D] = []
var previous_positions := {} # dizionario per memorizzare posizioni precedenti

@export var npc_base: PackedScene
@export var animation_sets: Array[SpriteFrames]
@export var speed: float = 3

func _ready() -> void:
	for n in get_children():
		if n is Path3D:
			percorsi.append(n)

	for p in percorsi:
		var follow := PathFollow3D.new()
		p.add_child(follow)

		# blocco la rotazione dell'NPC
		follow.rotation_mode = PathFollow3D.ROTATION_NONE

		var npc = npc_base.instantiate()
		var sprite_node: AnimatedSprite3D = npc.get_node("Sprite")
		if sprite_node:
			sprite_node.scale = Vector3(3, 3, 3)

		if sprite_node:
			var chosen_frames: SpriteFrames = animation_sets.pick_random()
			sprite_node.sprite_frames = chosen_frames
			sprite_node.play("idle")
		else:
			push_error("NPC istanziato ma il nodo Sprite non è stato trovato")

		follow.add_child(npc)

		var duration = p.curve.get_baked_length() / speed
		start_walking(follow, duration)

		# inizializzazione della posizione precedente
		previous_positions[follow] = follow.position

func _process(delta: float) -> void:
	for path3D in percorsi:
		for follow in path3D.get_children():
			if follow is PathFollow3D:
				var npc = follow.get_child(0) # 0 perché il primo figlio è l'NPC
				if not npc:
					continue
				
				# posizione attuale e precedente
				var current_pos = follow.position
				var prev_pos = previous_positions.get(follow, current_pos) #con current come secondo parametro per gestire le idle

				var direction = (current_pos - prev_pos)
				if direction.length() > 0:
					direction = direction.normalized()
				else:
					direction = Vector3.ZERO

				if npc.has_method("update_animation"):
					npc.update_animation(direction)

				# aggiorna posizione precedente
				previous_positions[follow] = current_pos


func start_walking(path: PathFollow3D, duration: float):
	var tween := get_tree().create_tween().set_loops()
	tween.tween_property(path, "progress_ratio", 1, duration)
	tween.tween_property(path, "progress_ratio", 0, duration)
