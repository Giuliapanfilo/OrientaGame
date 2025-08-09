extends Control

@onready var master_slider: HSlider = $CanvasLayer/Scaler/BaseGround/Master/MasterSlider
@onready var music_slider = $CanvasLayer/Scaler/BaseGround/Musica/MusicSlider
@onready var sfx_slider = $CanvasLayer/Scaler/BaseGround/SFX/SFXSlider

var previous_scene_path: String

var initial_master
var initial_music
var initial_sfx
var initial_joystick

func set_previous_scene(path: String) -> void:
	previous_scene_path = path


func _ready():
	var current_master = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	var current_music = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	var current_sfx = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	
	#Imposta il pulsante joystick in base all'opzione attuale
	if InteractionManager.joystick_enabled :
		_on_joystick_deactive_pressed()
	else :
		_on_joystick_active_pressed()
	
	
	# Imposta gli slider
	master_slider.value = current_master
	music_slider.value = current_music
	sfx_slider.value = current_sfx

	# Salva i valori iniziali per il reset (esci senza salvare)
	initial_master = current_master
	initial_music = current_music
	initial_sfx = current_sfx
	initial_joystick = InteractionManager.joystick_enabled

	# Connetti gli slider
	master_slider.value_changed.connect(_on_master_slider_changed)
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)

func _on_master_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_exit_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabelPressed.show()


func _on_exit_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Exit/ExitLabel.show()


func _on_save_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Save/SaveLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Save/SaveLabelPressed.show()


func _on_save_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Save/SaveLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Save/SaveLabel.show()


func _on_exit_pressed() -> void:
	master_slider.value = initial_master
	music_slider.value = initial_music
	sfx_slider.value = initial_sfx
	InteractionManager.joystick_enabled = initial_joystick
	
	$CanvasLayer.hide()



func _on_save_pressed() -> void:
	initial_master = master_slider.value
	initial_music = music_slider.value
	initial_sfx = sfx_slider.value
	initial_joystick = InteractionManager.joystick_enabled
	
	$CanvasLayer.hide()


func _on_joystick_active_pressed() -> void:
	$CanvasLayer/Scaler/BaseGround/Joystick/JoystickActive.hide()
	$CanvasLayer/Scaler/BaseGround/Joystick/JoystickDeactive.show()
	
	InteractionManager.joystick_enabled = false

func _on_joystick_deactive_pressed() -> void:
	$CanvasLayer/Scaler/BaseGround/Joystick/JoystickDeactive.hide()
	$CanvasLayer/Scaler/BaseGround/Joystick/JoystickActive.show()
	
	InteractionManager.joystick_enabled = true


func _on_music_slider_value_changed(value: float) -> void:
	print(music_slider.value)


func _on_sfx_slider_value_changed(value: float) -> void:
	print(sfx_slider.value)


func _on_master_slider_value_changed(value: float) -> void:
	print(master_slider.value)
