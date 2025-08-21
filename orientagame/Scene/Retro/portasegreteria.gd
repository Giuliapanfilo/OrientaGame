extends Node3D

@export var combat : Node

func _ready() -> void:
	$PortaSegreteria.interact = func():
		combat.start_battle()
		#var dial =  load("res://Dialogues/Battle/battle.dialogue") as  DialogueResource
		#print(dial.titles)
		#DialogueManager.show_dialogue_balloon(dial, "confused")
		#queue_free()
		#var line = await DialogueManager.get_next_dialogue_line(dial, "confused")
		#if line:
			#print("Testo linea:", line.text)
		#else:
			#print("Linea non trovata o vuota.")
		#DialogueManager.dialogue_ended.connect(func():
			#print("Dialogo finito!")
		#)
