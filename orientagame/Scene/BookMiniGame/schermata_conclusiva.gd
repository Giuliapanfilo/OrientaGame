extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_esci_pressed() -> void:
	$ButtonClick.play()
	await  $ButtonClick.finished
	
	get_tree().quit()


func _on_esci_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Esci/EsciLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Esci/EsciLabelPressed.show()
	$ButtonHover.play()

func _on_esci_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Esci/EsciLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Esci/EsciLabel.show()
	
	
func _on_continua_pressed() -> void:
	Engine.time_scale = 1
	$ButtonClick.play()
	await $ButtonClick.finished
	
	self.queue_free()
	

func _on_continua_mouse_entered() -> void:
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabel.hide()
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabelPressed.show()
	$ButtonHover.play()


func _on_continua_mouse_exited() -> void:
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabelPressed.hide()
	$CanvasLayer/Scaler/BaseGround/Continua/ContinuaLabel.show()
