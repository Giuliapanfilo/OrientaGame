extends CharacterBody3D
class_name Player

@export var speed := 3.0
@export var gravity := 9.8
@export var sprite : AnimatedSprite3D

var can_move = true

var last_direction = "down"
var last_action = "idle"

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		last_direction = "right"
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		last_direction = "left"
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
		last_direction = "down"
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
		last_direction = "up"

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

	if can_move:
		move_and_slide()
