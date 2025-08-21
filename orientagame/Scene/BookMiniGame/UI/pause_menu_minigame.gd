extends Control

var previous_scene_path: String


func set_previous_scene(path: String) -> void:
	previous_scene_path = path

func _ready() -> void:
	#pause(true)
	Engine.time_scale = 0
	for i in get_parent().get_children():
		if i.has_method("set_joystick"):
			i.set_joystick(false)

func pause(enable: bool):
	Engine.time_scale = 0 if enable else 1
	if enable:
		self.show()
	else:
		self.hide()
	

func _on_resume_pressed() -> void:
	#pause(false)
	Engine.time_scale = 1
	self.queue_free()
	
	for i in get_parent().get_children():
		if i.has_method("set_joystick"):
			i.set_joystick(true)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_gear_pressed() -> void:
	var option_scene = preload("res://UI/option_menu.tscn").instantiate()
	option_scene.set_previous_scene("res://Scene/BookMiniGame/UI/pause_menu_minigame.tscn")  # passiamo il menu di pausa
	get_parent().add_child(option_scene)
	self.hide()

# Hover effetti
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
