extends Control

@export var base_resolution := Vector2(1152, 648)

func _process(_delta):
	var screen_size = get_viewport_rect().size
	var scale_factor = min(screen_size.x / base_resolution.x, screen_size.y / base_resolution.y)
	
	scale = Vector2(scale_factor, scale_factor)
	
	# Calcola la dimensione effettiva scalata
	var scaled_size = base_resolution * scale_factor
	
	# Centra l'oggetto nella finestra
	position = (screen_size - scaled_size) / 2
