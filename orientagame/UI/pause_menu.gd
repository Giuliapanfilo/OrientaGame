extends Control

var previous_scene_path: String


func set_previous_scene(path: String) -> void:
	previous_scene_path = path


func _ready() -> void:
	#$ColorRect/AnimationPlayer.play("fade_out")
	pass


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
	#Sblocco movimento player
	InteractionManager.can_move = true
	
	$CanvasLayer.hide()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_gear_pressed() -> void:
	var option_scene = preload("res://UI/option_menu.tscn").instantiate()
	option_scene.set_previous_scene("res://UI/pause_menu.tscn")
	
	var parent = get_tree().current_scene
	if parent == null:
		parent = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	parent.add_child(option_scene)
	parent.hide()
	get_parent().add_child(option_scene)
	get_parent().hide()
	
