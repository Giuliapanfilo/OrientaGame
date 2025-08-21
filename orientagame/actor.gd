extends Node

class_name Actor

signal damaged(amount: int)
signal confused
signal died
signal healed

@export var hp : float = 100
@export var temp_priority : bool = false
@export var is_confused : bool = false
@export var remaining_damage : int = 0
@export var playerSprite : AnimatedSprite2D

@export var mosse : Array[Mossa]
#@export var name : String

func take_damage(amount:int) -> void:
	hp -= amount
	damaged.emit(amount)
	blink()
	
func heal(amount: int) -> void:
	amount = maxi(0, amount)
	hp += amount
	healed.emit(amount)
	
func confuse() -> void:
	is_confused = true
	confused.emit()
		
func blink():
	playerSprite.play("blink")
	
