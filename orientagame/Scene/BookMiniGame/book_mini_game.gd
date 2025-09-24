extends Node2D


@onready var animation_immortal := $Player/AnimationPlayer
@onready var sprite_animation := $Player/AnimationPlayer/Sprite2D
@onready var player: CharacterBody2D = $Player
@onready var song = $Song
@onready var spawner = $CanvasLayer/Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/DialogueManager").queue_free()
	get_node("/root/InteractionManager").queue_free()
	get_node("/root/Savefile").queue_free()
	get_node("/root/SceneLoader").queue_free()
	get_node("/root/UI").hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.get_immortal_state():
		sprite_animation.show()
		animation_immortal.play("Immortal")
		
	elif player.get_immortal_state() == false:
		sprite_animation.hide()
	
	sprite_animation.global_position = player.global_position - Vector2(0, 50)

func restore():
	for i in get_children():
		if i.is_in_group("enemies") or i.is_in_group("power_up"):
			i.queue_free()
	
	spawner.restore()
	player.restore()
	
	song.stop()
	song.play()

func win():
	self.queue_free()
