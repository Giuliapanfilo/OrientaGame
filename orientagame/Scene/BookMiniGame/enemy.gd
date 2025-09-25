extends CharacterBody2D

@onready var area := $Area2D
@onready var sprite := $AnimatedSprite2D
@export var sprites : Array[SpriteFrames]

const HP_NORMAL = 1
const HP_ELITE = 5
const SPEED_NORMAL = 100
const SPEED_ELITE = 50

var player : CharacterBody2D

var hp : int
var speed : int
var is_elite : bool = false

var direction = Vector2.ZERO
var last_direction = "idle"
var last_action = "idle"

var can_move = true

func _ready() -> void:
	var sprites_dimension = sprites.size()
	var random_index = randi() % sprites_dimension
	
	sprite.sprite_frames = sprites[random_index]
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
		can_move = false
		sprite.modulate = Color8(255, 255, 255, 143) # bianco con trasparenza
		$GPUParticles2D.emitting = true
		await get_tree().create_timer($GPUParticles2D.lifetime).timeout 
		queue_free()

	
	if can_move:
		direction = (player.global_position - global_position).normalized()
		velocity = speed * direction
	#direzione verso il player
	#direction = (player.global_position - global_position).normalized()
	#velocity = speed * direction
	
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
