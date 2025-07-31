extends Control


@onready var music_slider = $CanvasLayer/Scaler/BaseGround/MusicSlider
@onready var sfx_slider = $CanvasLayer/Scaler/BaseGround/SFXSlider

var previous_scene_path: String

func set_previous_scene(path: String) -> void:
	previous_scene_path = path


func _ready():
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)

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
	$CanvasLayer.hide()


func _on_Save_pressed() -> void:
	pass # Replace with function body.


func _on_joystick_active_pressed() -> void:
	$CanvasLayer/Scaler/BaseGround/JoystickActive.hide()
	$CanvasLayer/Scaler/BaseGround/JoystickDeactive.show()


func _on_joystick_deactive_pressed() -> void:
	$CanvasLayer/Scaler/BaseGround/JoystickDeactive.hide()
	$CanvasLayer/Scaler/BaseGround/JoystickActive.show()


func _on_music_slider_value_changed(value: float) -> void:
	print(music_slider.value)


func _on_sfx_slider_value_changed(value: float) -> void:
	print(sfx_slider.value)
