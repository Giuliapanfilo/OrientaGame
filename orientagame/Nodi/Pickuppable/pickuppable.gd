@tool

extends Node3D
class_name Pickuppable
@onready var interactionArea: InteractionArea = $InteractionArea
@export var meshinstance : MeshInstance3D
@export var collectible : Collectible 
var dialogue = load("res://Dialogues/collectibles.dialogue")


@export_tool_button('istanzia') var inst = func():
	meshinstance.mesh = collectible.mesh

@export var is_mesh_visible : bool = false : 
	get(): 
		return meshinstance.visible
	set(v):
		if meshinstance:
			meshinstance.visible = v


@export_range(1.0, 100, 0.001, "exp") var mesh_reduction : float = 1.0 :
	get():
		return meshinstance.scale.x
	set(v):
		meshinstance.scale = Vector3.ONE / v


func _ready() -> void:
	inst.call()
	meshinstance.visible = is_mesh_visible
	meshinstance.scale = Vector3.ONE / mesh_reduction
	interactionArea.interact = _on_interact
	interactionArea.is_secret = not is_mesh_visible


func _on_interact():
	meshinstance.visible = true
	SaveFile.discover(collectible.name)
	UI.item_preview.show_item(collectible)
	
	var path := "res://Dialogues/Collectibles/%s.dialogue" % collectible.name
	if not ResourceLoader.exists(path):
		push_error("Dialogue non trovato: %s" % path)
		return

	var dialogue_resource := load(path) as DialogueResource
	if dialogue_resource == null:
		push_error("Impossibile caricare come DialogueResource: %s" % path)
		return

	await DialogueManager.show_dialogue_balloon(dialogue_resource, "")
	queue_free()
	
	#await DialogueManager.show_dialogue_balloon(dialogue, collectible.name)
	#queue_free()
