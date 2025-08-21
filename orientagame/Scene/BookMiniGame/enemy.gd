extends CharacterBody2D

@onready var area := $Area2D
@onready var sprite := $AnimatedSprite2D
@export var sprites : Array[SpriteFrames]

const HP_NORMAL = 3
const HP_ELITE = 10
const SPEED_NORMAL = 100
const SPEED_ELITE = 50

var player : CharacterBody2D

var hp : int
var speed : int
var is_elite : bool = false

var direction = Vector2.ZERO
var last_direction = "idle"
var last_action = "idle"

func _ready() -> void:
	sprite.sprite_frames = sprites.pick_random()
	add_to_group("enemies")
	
	for i in get_parent().get_children():
		if i.is_in_group("player"):
			player = i
	
	if is_elite:
		sprite.scale = sprite.scale * 2
		area.scale = area.scale * 2
		
		hp = HP_ELITE
		speed = SPEED_ELITE
	else:
		hp = HP_NORMAL
		speed = SPEED_NORMAL

func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
	
	#direzione verso il player
	direction = (player.global_position - global_position).normalized()
	velocity = speed * direction
	
# Animazioni
	if direction != Vector2.ZERO:
		last_action = "move"
		if abs(direction.x) > abs(direction.y):
			last_direction = "right" if direction.x > 0 else "left"
		else:
			last_direction = "up" if direction.y < 0 else "down"
	else:
		last_action = "idle"

	sprite.play(last_action + "_" + last_direction)
	
	move_and_slide()

func take_damage():
	hp -= 1

func set_is_elite(flag : bool = false):
	is_elite = flag
