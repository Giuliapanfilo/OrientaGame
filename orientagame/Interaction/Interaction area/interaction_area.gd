extends Area3D
class_name InteractionArea

@export var action_name: String = "Interact"

var interact: Callable = func():
	pass


func _on_body_entered(body: Node3D) -> void:
	InteractionManager.register_area(self)

func _on_body_exited(body: Node3D) -> void:
	InteractionManager.unregister_area(self)
