@tool
extends Resource
class_name Mossa

@export var name : String
@export_multiline var expression:String = ""
var inputs:Array[String] = ["agent", "target"]
var agent : Actor
var target : Actor
var dlog : DialogueResource = preload("res://Dialogues/Battle/battle.dialogue")

const CONFUSION_DMG := 10
var _expr:Expression

func _ensure() -> bool:
	if _expr == null:
		_expr = Expression.new()
		var err := _expr.parse(expression, inputs)
		if err != OK:
			push_error("Expression parse error: %s" % _expr.get_error_text())
			return false
	return true



func do():
	#handle confusione
	if agent.is_confused :
		DialogueManager.show_dialogue_balloon(dlog, "confused")
		#print(agent.name, " è confuso!")
		agent.is_confused = false
		if  randi_range(0,1) == 0:
			agent.take_damage(CONFUSION_DMG)
			DialogueManager.get_next_dialogue_line(dlog, "confusion")
			#print(agent.name, " è così confuso da colpirsi da solo!")
			if agent.hp <= 0:
				return target
			return null

	DialogueManager.show_dialogue_balloon(dlog, name)

	_exec([agent, target])

	if agent.remaining_damage > 0:
		agent.take_damage(agent.remaining_damage)
		agent.remaining_damage = 0

	if target.hp <= 0:
		return agent

	return null

func _exec(args:Array, base:Variant = null) -> Variant:
  # NOTE: base permette di esporre funzioni helper all'espressione (vedi Mossa).
	if not _ensure():
		return null
	return _expr.execute(args, base, true)
