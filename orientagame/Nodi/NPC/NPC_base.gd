extends CharacterBody3D

@onready var sprite: AnimatedSprite3D = $Sprite

var previous_progress_ratio := 0.0
var path_follow: PathFollow3D = null

func _ready():
	# Ottieni il PathFollow3D genitore (dove è attaccato questo NPC)
	path_follow = get_parent() if get_parent() is PathFollow3D else null
	if path_follow:
		previous_progress_ratio = path_follow.progress_ratio

func update_animation(direction: Vector3) -> void:
	if not sprite:
		return

	if direction.length() == 0:
		sprite.play("idle")
		return

	# Decidi animazione in base alla direzione predominante
	if abs(direction.x) > abs(direction.z):
		if direction.x > 0:
			sprite.play("move_right")
		else:
			sprite.play("move_left")
	else:
		if direction.z > 0:
			sprite.play("move_down")
		else:
			sprite.play("move_up")
