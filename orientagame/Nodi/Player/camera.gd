# camera.gd
extends Camera3D

@onready var start_pos : Vector3 = position
@onready var start_rot : Vector3 = rotation_degrees
var tween : Tween


func move_focus(target_pos, target_rot, duration):
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "position", start_pos + target_pos, duration)
	tween.tween_property(self, "rotation_degrees", start_rot + target_rot, duration)
	await tween.finished
