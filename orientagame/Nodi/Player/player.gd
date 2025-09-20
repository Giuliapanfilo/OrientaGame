extends CharacterBody3D
class_name Player

@export var speed := 3.0
@export var gravity := 9.8
@export var sprite : AnimatedSprite3D
@onready var camera = $Camera

var can_move = true
var can_animate = true

var last_direction = "up"
var last_action = "idle"

func _ready() -> void:
	if OS.is_debug_build():
		speed = 10

func _physics_process(delta: float) -> void:
	#var joystickVector = GlobalUi.getJoystickVec()
	var direction := Vector3.ZERO

	# Input da tastiera
	direction.x += Input.get_axis("move_left", "move_right")
	direction.z += Input.get_axis("move_up", "move_down")

	
	direction = direction.normalized()

	# Animazioni
	if can_animate:
		if direction != Vector3.ZERO:
			last_action = "move"
			if abs(direction.x) > abs(direction.z) :
				last_direction = "right" if direction.x > 0 else "left"
			else:
				last_direction = "up" if direction.z < 0 else "down"
		else:
			last_action = "idle"

	sprite.play(last_action + "_" + last_direction)

	# Gravità
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Movimento
	if can_move:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		move_and_slide()

func get_camera():
	for c in get_children():
		if c is Camera3D:
			return c
