extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene
@export var powerUp : PackedScene

var distance : float = 400

var minute : int:
	set(value):
		minute = value
		%Minutes.text = str(minute)
		if %Minutes.text == "3":
			win()

var second : int:
	set(value):
		second = value
		if second >= 60:
			second -= 60
			minute += 1
		%Seconds.text = str(second).lpad(2, "0")


func spawn(pos : Vector2, is_elite : bool = false):
	var enemy_istance = enemy.instantiate()
	
	enemy_istance.position = pos
	enemy_istance.set_is_elite(is_elite)
	get_tree().current_scene.add_child(enemy_istance)

func get_random_position() -> Vector2 :
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number : int = 1, is_elite : bool = false):
	for i in range(number):
		spawn(get_random_position(), is_elite)

func _on_timer_timeout() -> void:
	second += 1


func _on_pattern_timeout() -> void:
	amount(second % 10, false)


func _on_elite_timeout() -> void:
	amount(1, true)


func _on_power_up_timeout() -> void:
	spawn_powerup(get_random_position())


func spawn_powerup(pos : Vector2):
	var powerup_istance = powerUp.instantiate()
	
	powerup_istance.position = pos
	get_tree().current_scene.add_child(powerup_istance)


func restore():
	second = 0
	minute = 0

func win():
	print("HAI VINTO!")
	var win_scene = preload("res://Scene/BookMiniGame/book_win.tscn").instantiate()
	get_tree().root.add_child(win_scene)
	pass
