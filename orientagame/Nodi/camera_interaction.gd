extends Area3D

@export var secondary_rot : Vector3
@export var secondary_pos : Vector3
var base_pos
var base_rot
var camera
const DURATION: float = 0.5


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		camera = get_camera(body)
		move_camera(true)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		move_camera(false)


func move_camera(inarea):
	var tween_rot = create_tween()
	var tween_pos = create_tween()
	var target_rot = secondary_rot if inarea else base_rot
	var target_pos = secondary_pos if inarea else base_pos
	tween_rot.tween_property(camera, "rotation", target_rot, DURATION)
	tween_pos.tween_property(camera, "position", target_pos, DURATION)
	await tween_pos.finished
	print("Camera spostata", inarea)
	
func get_camera(player):
	for c in player.get_children():
		if c is Camera3D:
			camera = c
			base_rot = c.rotation
			base_pos = c.position
			return camera
			
