extends Node3D


@onready var player = get_tree().get_first_node_in_group("player")
#@onready var label: Label3D = $Label
@onready var freccina: Sprite3D = $Freccina

const text_offset := Vector3(0, 0.2, 0)
const freccina_offset := Vector3(0, 0.4, 0)
var active_areas = []
var can_interact = true
var do_interact : Callable = func () :
	if can_interact and active_areas.size() > 0 :
		can_interact = false
		#label.hide()
		freccina.hide()
		await active_areas[0].interact.call()
		can_interact = true
	else :
		push_error("Non posso interagire")

func register_area(area: InteractionArea):
	active_areas.push_back(area)


func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)


func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		#label.text = active_areas[0].action_name
		var pos = active_areas[0].global_position 
		#label.global_position = pos + text_offset
		freccina.global_position = pos + freccina_offset
		#label.show()
		if not active_areas[0].is_secret:
			freccina.show()
	else:
		#label.hide()
		freccina.hide()


func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player


func _input(event):
	if event.is_action_pressed("Interact") :
		await do_interact.call()
