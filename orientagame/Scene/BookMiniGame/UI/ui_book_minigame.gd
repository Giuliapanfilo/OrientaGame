extends Control

@onready var joystick_move = $CanvasLayer/JoystickMove
@onready var song: AudioStreamPlayer = $"../Song"


func _ready() -> void:
	if UI.joystick.visible:
		joystick_move.show()
	else:
		joystick_move.hide()

func _on_pause_button_pressed() -> void:
	#Blocco movimento personaggio
	#can_move = false
	#set_joystick(false)
	#song.stream_paused = true
	var pause_scene = preload("res://Scene/BookMiniGame/UI/pause_menu_minigame.tscn").instantiate()
	pause_scene.set_previous_scene("res://Scene/BookMiniGame/book_mini_game.tscn")
	
	get_parent().add_child(pause_scene)

func set_joystick (enabled : bool) :
	joystick_move.visible = enabled
	joystick_move.mouse_filter = MouseFilter.MOUSE_FILTER_STOP if enabled else MouseFilter.MOUSE_FILTER_IGNORE
	
	#joystick_aim.visible = enabled
	#joystick_aim.mouse_filter = MouseFilter.MOUSE_FILTER_STOP if enabled else MouseFilter.MOUSE_FILTER_IGNORE 
