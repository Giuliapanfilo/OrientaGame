extends Control

func _ready() -> void:
	Engine.time_scale = 0
	var minigame_node = get_parent().get_children()
	minigame_node[0].queue_free()
	minigame_node[1].queue_free()


func _on_continua_pressed() -> void:
	Engine.time_scale = 1
	$ButtonClick.play()
	await $ButtonClick.finished
	
	
	var scena_collezionabile = preload("res://Scene/BookMiniGame/raccolta_libro.tscn").instantiate()
	get_parent().add_child(scena_collezionabile)
	
	self.queue_free()
	
	

func _on_continua_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabelPressed.show()
	$ButtonHover.play()


func _on_continua_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabel.show()
