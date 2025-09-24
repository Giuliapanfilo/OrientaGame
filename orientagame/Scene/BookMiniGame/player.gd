extends CharacterBody2D

@onready var sound_shoot: AudioStreamPlayer = $SoundShoot
@onready var sprite := $AnimatedSprite2D

@onready var initial_position = self.global_position

const MAX_HP = 3
const SPEED = 300.0
const SHOOT_INTERVAL = 0.5  # tempo tra uno sparo e l'altro (secondi)

const SPEED_POWERUP = 600.0
const SHOOT_INTERVAL_POWERUP = SHOOT_INTERVAL/2

#idx0 Speed, idx1 Invincibilità, idx2 Shoot
var powerup : Array[bool] = [false, false, false]

var hp : int = 3

var shoot_timer = 0.0
var can_shoot = true
var is_immortal = false
var is_hit = false
var lock_animation = false

var last_action = "idle"
var last_direction = "down"

var local_shoot_interval = SHOOT_INTERVAL
var local_speed = SPEED

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	# Movimento
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()

	# Animazioni
	if not lock_animation:
		if direction != Vector2.ZERO:
			last_action = "move"
			if abs(direction.x) > abs(direction.y):
				last_direction = "right" if direction.x > 0 else "left"
			else:
				last_direction = "up" if direction.y < 0 else "down"
		else:
			last_action = "idle"

	sprite.play(last_action + "_" + last_direction)
	
	velocity = direction * local_speed
	move_and_slide()
	
	# Sparo automatico
	shoot_timer -= delta
	if shoot_timer <= 0:
		var target = get_nearest_enemy()
		if target != null:
			shoot((target.global_position - global_position).normalized())
			shoot_timer = local_shoot_interval


func shoot(aim : Vector2):
	sound_shoot.play(0.2)
	var projectile = preload("res://Scene/BookMiniGame/book.tscn").instantiate()
	projectile.global_position = global_position
	projectile.direction = aim
	get_parent().add_child(projectile)


func get_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")  # assicurati di mettere tutti i nemici in questo gruppo
	if enemies.is_empty():
		return null
	var nearest = enemies[0]
	var dist = global_position.distance_to(nearest.global_position)
	for enemy in enemies:
		var d = global_position.distance_to(enemy.global_position)
		if d < dist:
			dist = d
			nearest = enemy
	return nearest


func take_damage():
	if not is_immortal and not is_hit:
		start_blink()
		hp -= 1
		if hp <= 0:
			lose()


func restore():
	hp = MAX_HP
	self.global_position = initial_position
	if powerup[0]:
		#powerup[0] = false
		set_speed_powerup()
	if powerup[1]:
		#powerup[1] = false
		set_shoot_powerup()
	if powerup[2]:
		#powerup[2] = false
		set_invicibilità_powerup()


func lose():
	Engine.time_scale = 0
	var gameover_scene = preload("res://Scene/BookMiniGame/UI/book_game_over.tscn").instantiate()
	get_tree().root.add_child(gameover_scene)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and not is_immortal and not is_hit:
		take_damage()
		is_hit = true
		$"Immunità".start()

func _on_immunità_timeout() -> void:
	is_hit = false
	stop_blink()


func set_speed_powerup():
	if local_speed == SPEED:
		powerup[0] = true
		local_speed = SPEED_POWERUP
		$PowerUpDuration.start()
	else:
		powerup[0] = false
		local_speed = SPEED


func set_shoot_powerup():
	if local_shoot_interval == SHOOT_INTERVAL:
		powerup[1] = true
		local_shoot_interval = SHOOT_INTERVAL_POWERUP
		$PowerUpDuration.start()
	else:
		powerup[1] = false
		local_shoot_interval = SHOOT_INTERVAL

func set_invicibilità_powerup():
	if not is_immortal:
		powerup[2] = true
		is_immortal = true
		$PowerUpDuration.start()
		start_blink()
	else:
		powerup[2] = false
		is_immortal = false
		stop_blink()


func _on_power_up_duration_timeout() -> void:
	if powerup[0]:
		#powerup[0] = false
		set_speed_powerup()
	if powerup[1]:
		#powerup[1] = false
		set_shoot_powerup()
	if powerup[2]:
		#powerup[2] = false
		set_invicibilità_powerup()

func start_blink():
	sprite.modulate = Color(1,1,1,0.5) # semitrasparente

func stop_blink():
	sprite.modulate = Color(1,1,1,1)

func get_immortal_state() -> bool:
	return is_immortal
