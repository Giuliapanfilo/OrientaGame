extends Control


func _on_pause_button_pressed() -> void:
	var pause_scene = preload("res://UI/pause_menu.tscn").instantiate()
	pause_scene.set_previous_scene("res://UI/ui_gameplay.tscn")
	get_tree().current_scene.add_child(pause_scene)
	get_tree().current_scene.hide()


func _on_interaction_button_pressed() -> void:
	print("Interagisco")
	var interaction_manager = get_tree().get_first_node_in_group("interaction_manager")
	if interaction_manager:
		interaction_manager.interact_if_possible()
