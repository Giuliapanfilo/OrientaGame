extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Song.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Libro.rotation.y = $Libro.rotation.y - 0.01


func _on_timer_timeout() -> void:
	var schermata_conclusiva = preload("res://Scene/BookMiniGame/SchermataConclusiva.tscn").instantiate()
	get_parent().add_child(schermata_conclusiva)
	self.queue_free()
