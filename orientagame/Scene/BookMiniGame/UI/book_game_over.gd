extends Control

var minigame_scene = preload("res://Scene/BookMiniGame/book_mini_game.tscn").instantiate()


func _on_riprova_pressed() -> void:
	var player
	for i in get_tree().get_nodes_in_group("player"):
		player = i
	
	get_tree().root.add_child(minigame_scene)
	Engine.time_scale = 1
	if player.has_method("restore"):
		player.restore()
	self.queue_free()


func _on_riprova_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Riprova/RiprovaLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Riprova/RiprovaLabelPressed.show()


func _on_riprova_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Riprova/RiprovaLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Riprova/RiprovaLabel.show()
