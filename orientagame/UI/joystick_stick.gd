extends Sprite2D

@onready var parent = $".."

var pressing = false

@export var maxLength = 200
var deadzone = 15

func _ready():
	deadzone = parent.deadzone
	maxLength *= parent.scale.x

func _process(delta):
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle)*maxLength
			global_position.y = parent.global_position.y + sin(angle)*maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta*10)
		parent.posVector = Vector3(0,0,0)
		
func calculateVector():
	parent.posVector = Vector3.ZERO
	
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x) / maxLength

	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		# Invertiamo Y per farlo diventare Z (a seconda di come il mondo è orientato)
		parent.posVector.z = (global_position.y - parent.global_position.y) / maxLength


func _on_button_button_down():
	pressing = true


func _on_button_button_up():
	pressing = false
