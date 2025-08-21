extends Node

@export var first_scene : PackedScene
@onready var current_scene = $CurrentScene
@onready var player := $Player
@onready var panel := $Panel
var tween : Tween
@export var transition_duration := .6

func _ready() -> void:
	# Se esiste già un'altra istanza attiva (cioè non sono "me stesso" nel singleton)
	if SceneLoader != self:
		print("⚠️ Duplicate. destroying this one:", self.name)
		queue_free()
	swap(first_scene, "Start")

func transition(do_dark : bool):
	player.can_move = not do_dark
	tween = create_tween()
	var target = Color("#000000", int(do_dark))
	tween.tween_property(panel, "modulate", target, transition_duration )
	await  tween.finished

func swap(destination: PackedScene, at: StringName) -> void:
	if not destination:
		push_error("Scena inesistente")
		return
	await  transition(true)
	# elimina scena vecchia
	for c in current_scene.get_children():
		c.queue_free()
	
	# piazza scena nuova
	var new_scene = destination.instantiate()
	current_scene.add_child(new_scene)
	
	# Spawna
	var spawner = get_spawn(new_scene, at)
	if spawner: 
		player.position = spawner.global_position
	else:
		push_error("Spawner non trovato in ", current_scene.name) 
	#print("swap to ", destination)
	player.camera.move_focus(Vector3.ZERO, Vector3.ZERO, 0.01)
	#await get_tree().create_timer(.2).timeou
	#await transition(false)
	await transition(false)


func get_spawn(scene: Node3D, at: StringName=&"") -> Marker3D:
	for c in scene.get_children():
		if c is Marker3D and c.is_in_group("spawn"):
			if at == &"" or at.to_lower() in c.name.to_lower():
				return c
	return null
