extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/DialogueManager").queue_free()
	get_node("/root/InteractionManager").queue_free()
	get_node("/root/Savefile").queue_free()
	get_node("/root/SceneLoader").queue_free()
	get_node("/root/UI").hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
