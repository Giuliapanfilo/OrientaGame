extends Control

@onready var item_preview: ItemPreview = $Scaler/ItemPreview
@onready var joystick = $Scaler/Joystick


func _on_interaction_button_pressed() -> void:
	#Input.action_press("Interact")
	#get_tree().create_timer(0.2)
	#Input.action_release("Interact")
	InteractionManager.do_interact.call()


func _on_pause_button_pressed() -> void:
	#Blocco movimento personaggio
	#can_move = false
	#set_joystick(false)
	var pause_scene = preload("res://UI/pause_menu.tscn").instantiate()
	pause_scene.set_previous_scene("res://UI/global_ui.gd")
	
	get_parent().add_child(pause_scene)
	get_parent().hide()

func set_joystick (enabled : bool) :
	joystick.visible = enabled
	joystick.mouse_filter = MouseFilter.MOUSE_FILTER_STOP if enabled else MouseFilter.MOUSE_FILTER_IGNORE 
