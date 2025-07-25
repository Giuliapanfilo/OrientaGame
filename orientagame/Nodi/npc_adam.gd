extends CharacterBody3D

@onready var interactionArea: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
var prova = load("res://Dialogue/main.dialogue")

var dialogue_active = false

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	interactionArea.interact = Callable(self, "_on_interact")
		
func _on_interact():
	if dialogue_active:
		return
	dialogue_active = true
	DialogueManager.show_dialogue_balloon(prova, "start")
	DialogueManager.dialogue_ended.emit(prova)

func _on_dialogue_ended(dialogo):
	dialogue_active = false
	pass
