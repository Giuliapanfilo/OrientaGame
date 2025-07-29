extends Node2D

var button_type = null


func _on_start_pressed():
	button_type = "start"
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("fade_in")


func _on_survey_pressed() -> void:
	button_type = "survey"
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("fade_in")


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	button_type = "options"
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("fade_in")


func _on_start_mouse_entered() -> void:
	$BottonManager/Start/StartLabel.hide()
	$BottonManager/Start/StartLabelPressed.show()


func _on_start_mouse_exited() -> void:
	$BottonManager/Start/StartLabelPressed.hide()
	$BottonManager/Start/StartLabel.show()


func _on_survey_mouse_entered() -> void:
	$BottonManager/Survey/SurveyLabel.hide()
	$BottonManager/Survey/SurveyLabelPressed.show()


func _on_survey_mouse_exited() -> void:
	$BottonManager/Survey/SurveyLabelPressed.hide()
	$BottonManager/Survey/SurveyLabel.show()


func _on_quit_mouse_entered() -> void:
	$BottonManager/Quit/QuitLabel.hide()
	$BottonManager/Quit/QuitLabelPressed.show()


func _on_quit_mouse_exited() -> void:
	$BottonManager/Quit/QuitLabelPressed.hide()
	$BottonManager/Quit/QuitLabel.show()


#Aggiungere i file dele scene corrette
func _on_fade_timer_timeout() -> void:
	print("il timer è scaduto")
	if button_type == "start" :
		get_tree().change_scene_to_file("res://Scene/pianterreno.tscn")
	
	elif button_type == "options" :
		get_tree().change_scene_to_file("res://UI/main_menu.tscn")
	
	elif button_type == "survey" :
		get_tree().change_scene_to_file("res://UI/main_menu.tscn")
