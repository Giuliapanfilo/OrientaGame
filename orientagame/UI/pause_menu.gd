extends Control

var previous_scene_path: String


func set_previous_scene(path: String) -> void:
	previous_scene_path = path


func _ready() -> void:
	pause(true)


func _on_resume_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Resume/ResumeLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Resume/ResumeLabelPressed.show()


func _on_resume_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Resume/ResumeLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Resume/ResumeLabel.show()


func _on_exit_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabelPressed.show()


func _on_exit_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabel.show()


func _on_resume_pressed() -> void:
	pause(false)


func pause(enable : bool):
	Engine.time_scale = 0 if enable else 1
	if not enable:
		queue_free()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_gear_pressed() -> void:
	var option_scene = preload("res://UI/option_menu.tscn").instantiate()
	option_scene.set_previous_scene(get_scene_file_path())  # oppure previous_scene_path se lo vuoi manuale

	# Aggiungi l'opzione come figlio dello stesso parent del menu di pausa
	var parent = get_parent()
	parent.add_child(option_scene)

	# Nascondi solo il menu di pausa, non il parent intero
	self.hide()
	
