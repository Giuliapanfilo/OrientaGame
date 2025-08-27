extends Node


@onready var mentore : CharacterBody3D = $"Antonio"
@onready var verso_inizio : Path3D = $PercorsoMentore
@onready var verso_dib : Path3D = $Percorso101
@export var visible : bool = false
#@onready var player : Player = SceneLoader.player

var dialogo =load("res://Dialogues/tuttorial.dialogue")



func _ready() -> void:
	if not visible:
		return
	await get_tree().process_frame
	SceneLoader.player.can_move = false
	SceneLoader.player.lock_animation = true
	DialogueManager.dialogue_ended.connect(func(dialogue):
		if dialogue == dialogo:
			print("mammazzo")
			SceneLoader.player.can_move = true
			SceneLoader.player.lock_animation = false
			SceneLoader.player.reparent(SceneLoader)
			queue_free()
		)
	# aspetta che finisca di percorrere
	await walk_path(mentore, verso_inizio, 3)
	
	#avvia dialogo
	await DialogueManager.show_dialogue_balloon(dialogo, "start")
	# aspetta che il mentore pronunzi le prime frasi
	await get_tree().create_timer(5).timeout
	
	# partite entrambi verso il dib
	walk_path(mentore, verso_dib, 15)
	await get_tree().create_timer(0.5).timeout #tu con un poco di ritardo
	SceneLoader.player.last_action = 'move'
	SceneLoader.player.last_direction = 'up'
	SceneLoader.player.sprite.play("move_up") #e con l'animazione della camminata
	await walk_path(SceneLoader.player,  verso_dib, 15)
	#await DialogueManager.show_dialogue_balloon(dialogo, "parte2")
	SceneLoader.player.last_action = 'idle'
	

	
func walk_path(character:CharacterBody3D, path : Path3D, duration=5):
	var follow = PathFollow3D.new()
	path.add_child(follow)
	character.reparent(follow)
	var tween := get_tree().create_tween()
	tween.tween_property(follow, "progress_ratio", 1, duration)

	await tween.finished
	print("ho spostato ", character.name)
	if character is Player:
		character.reparent(SceneLoader)
	else:
		character.reparent(get_parent())

	
