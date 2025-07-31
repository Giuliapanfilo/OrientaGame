extends Node

@export var first_scene : PackedScene
@onready var current_scene = $CurrentScene
@onready var player := $Player

#func _ready() -> void:
	# Se esiste già un'altra istanza attiva (cioè non sono "me stesso" nel singleton)
	#if SceneLoader != self:
		#print("⚠️ Duplicate. destroying this one:", self.name)
		#queue_free()
#
	#swap(first_scene)
	#print("🚀 swap called on ready with: ", first_scene)


func swap(destination: PackedScene) -> void:
	if not destination:
		push_error("Scena inesistente")
		return
	player.can_move = false
	
	# elimina scena vecchia
	for c in current_scene.get_children():
		c.queue_free()
	
	# piazza scena nuova
	var new_scene = destination.instantiate()
	current_scene.add_child(new_scene)
	
	# Spawna
	var spawner = get_spawn(new_scene)
	if spawner: 
		player.position = spawner.global_position
	else:
		push_error("Spawner non trovato in ", current_scene.name) 
	print("swap to ", destination)
	player.can_move = true


func get_spawn(scene: Node3D) -> Marker3D:
	for c in scene.get_children():
		if c is Marker3D and c.is_in_group("spawn"):
			return c
	return null
