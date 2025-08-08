extends Area3D
class_name Confini

@export_enum("up", "down", "left", "right") var redirect: String

var dialog : Resource = load("res://Dialogues/edge.dialogue")

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("Player oltrepassa i confini! andava verso ", body.last_direction)
		Input.action_release("ui_up")
		Input.action_release("ui_down")
		Input.action_release("ui_left")
		Input.action_release("ui_right")
		#SceneLoader.player.can_move = false
		#SceneLoader.player.can_move = true
		Input.action_press("ui_"+redirect)
		
		DialogueManager.show_dialogue_balloon(dialog, "start")
		get_tree().create_timer(1.5).timeout.connect(func():
			Input.action_release("ui_"+redirect)
			DialogueManager.get_next_dialogue_line(dialog)
			DialogueManager.dialogue_ended.emit(dialog))
		
		
		


#func _on_body_exited(body: Node3D) -> void:
	#pass # Replace with function body.
