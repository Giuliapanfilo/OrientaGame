extends CharacterBody3D
class_name Player

@onready var joystick: Node2D = $Camera/Scaler/Joystick

@export var speed := 3.0
@export var gravity := 9.8
@export var sprite : AnimatedSprite3D

var last_direction = "down"
var last_action = "idle"

func _process(_delta):
	$Camera/Scaler/Joystick.visible = InteractionManager.joystick_enabled


func _physics_process(delta):
	var direction = joystick.posVector

		# Input da tastiera
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1

	# Se il joystick è stato mosso più della deadzone
	if joystick.posVector.length() > 0.1:
		direction.x += joystick.posVector.x
		direction.z += joystick.posVector.z

	# Determina la direzione principale per l'animazione
	if abs(direction.x) > abs(direction.z):
		last_direction = "right" if direction.x > 0 else "left"
	elif abs(direction.z) > 0:
		last_direction = "down" if direction.z > 0 else "up"


	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	last_action = "idle" if direction == Vector3.ZERO else "move"
	sprite.play(last_action + "_" + last_direction)

	# Gravity se vuoi farlo stare a terra (o per salti futuri)
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	if InteractionManager.can_move:
		move_and_slide()
