extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

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
var is_immune = false
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
	hp -= 1
	if hp <= 0:
		lose()


func restore():
	hp = MAX_HP


func lose():
	Engine.time_scale = 0
	var gameover_scene = preload("res://Scene/BookMiniGame/UI/book_game_over.tscn").instantiate()
	get_tree().root.add_child(gameover_scene)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and not is_immune:
		take_damage()
		is_immune = true
		$"Immunità".start()


func _on_immunità_timeout() -> void:
	is_immune = false


func set_speed_powerup():
	if local_speed == SPEED:
		powerup[0] = true
		local_speed = SPEED_POWERUP
		$PowerUpDuration.start()
	else:
		powerup[0] = false
		local_speed == SPEED

func set_shoot_powerup():
	if local_shoot_interval == SHOOT_INTERVAL:
		powerup[1] = true
		local_shoot_interval = SHOOT_INTERVAL_POWERUP
		$PowerUpDuration.start()
	else:
		powerup[1] = false
		local_shoot_interval = SHOOT_INTERVAL

func set_invicibilità_powerup():
	if not is_immune:
		print("INVINCIBILE")
		powerup[2] = true
		is_immune = true
		$PowerUpDuration.start()
	else:
		print("MORTALE")
		powerup[2] = false
		is_immune = false


func _on_power_up_duration_timeout() -> void:
	print(powerup)
	var pos = 0
	for i in powerup:
		pos += 1
		if i == true:
			if pos == 0:
				print("annullo VELOCITA")
				set_speed_powerup()
			elif pos == 1:
				print("annullo INVINCIBILITA")
				set_invicibilità_powerup()
			elif pos == 2:
				print("annullo SPARO")
				set_shoot_powerup()
		i = false
	print(powerup)
