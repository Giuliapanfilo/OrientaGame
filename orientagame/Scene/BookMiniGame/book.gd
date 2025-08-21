extends Node2D

const SPEED = 300

@onready var animation = $StaticBody2D/AnimatedSprite2D
var direction := Vector2.ZERO

func _ready() -> void:
	animation.play("default")

func _process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body.has_method("take_damage"):
		body.take_damage()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
