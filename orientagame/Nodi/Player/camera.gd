# res://cam/SmoothCamera.gd
extends Camera3D

@export var smooth_speed := 5.0   

var local_xform: Transform3D

func _ready() -> void:
	local_xform = transform

func _process(delta: float) -> void:
	# calcoliamo dove "dovrebbe" stare la camera in base al parent
	var desired_global: Transform3D = get_parent().global_transform * local_xform
	# interpoliamo il global_transform corrente verso quello desiderato
	global_transform = global_transform.interpolate_with(desired_global, smooth_speed * delta)
