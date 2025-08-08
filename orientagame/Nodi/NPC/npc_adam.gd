extends CharacterBody3D
class_name NPC

@onready var interactionArea: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@export var character : Character
var current_dialogue_line := 0

#var prova = load("res://Dialogues/main.dialogue")
var is_walking = false
var dialogue_active = false


func _ready():
	sprite.sprite_frames = character.sprite
	DialogueManager.dialogue_started.connect(func(any): 
		interactionArea.monitoring = false )
	DialogueManager.dialogue_ended.connect(func(any): 
		if character.dialogue_cycle == 0 or character.dialogues.size() > current_dialogue_line:
			interactionArea.monitoring = true)
	interactionArea.interact = Callable(self, "_on_interact")


func _on_interact():
	var dialogue = _next_dialogue()
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, "start")


func _next_dialogue() -> DialogueResource:
	var d = null
	if character.dialogue_cycle == 0:
		d = character.dialogues.pick_random()
	elif character.dialogues.size() > current_dialogue_line:
		d = character.dialogues[current_dialogue_line]
		current_dialogue_line +=1
	return d


func _process(delta: float) -> void:
	if not is_walking:
		return
	var curr_animation = 'down'
	var directions = {45:'down', 135:'right', 225:'up', 315:'left'}
	for d in directions:
		if rotation_degrees.y <= d:
			curr_animation = directions[d]
			break
	if sprite.animation != 'walk' + curr_animation:
		sprite.animation = 'walk' + curr_animation
