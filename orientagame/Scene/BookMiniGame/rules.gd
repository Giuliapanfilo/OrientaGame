extends Control
@onready var song := $"../Song"

func _ready() -> void:
	Engine.time_scale = 0
	song.stop()

func _on_resume_mouse_entered() -> void:
	$CanvasLayer/Scaler/Resume/ResumeLabel.hide()
	$CanvasLayer/Scaler/Resume/ResumeLabelPressed.show()
	$ButtonHover.play()

func _on_resume_mouse_exited() -> void:
	$CanvasLayer/Scaler/Resume/ResumeLabelPressed.hide()
	$CanvasLayer/Scaler/Resume/ResumeLabel.show()

func _on_resume_pressed() -> void:
	Engine.time_scale = 1
	$ButtonClick.play()
	await $ButtonClick.finished
	song.play()
	#var scene_res = load("res://Scene/BookMiniGame/book_mini_game.tscn")
	#var scene_instance = scene_res.instantiate()
	#get_parent().add_child(scene_instance)
	self.queue_free()
