extends Node2D

@export var power_up : Array[Texture2D]
@onready var sprite := $Sprite2D
var idx = 0

const IDX_FAST = 0
const IDX_INVICIBLE = 1
const IDX_SHOOT = 2

func _ready() -> void:
	idx = randi_range(0, power_up.size()-1)
	sprite.texture = power_up.get(idx)


func _process(delta: float) -> void:
	sprite.rotate(delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if idx == IDX_FAST:
			if body.has_method("set_speed_powerup"):
				body.set_speed_powerup()
		elif idx == IDX_INVICIBLE:
			if body.has_method("set_invicibilità_powerup"):
				body.set_invicibilità_powerup()
		elif idx == IDX_SHOOT:
			if body.has_method("set_shoot_powerup"):
				body.set_shoot_powerup()
		
		self.queue_free()
