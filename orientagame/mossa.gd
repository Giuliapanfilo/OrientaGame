@tool
extends Resource
class_name Mossa

@export_multiline var code:String = ""
@export var inputs:Array[String] = ["agent", "target"]
var agent : Actor
var target : Actor
const CONFUSION_DMG := 10
var _expr:Expression

enum WHOWON {AGENT, TARGET, NONE}

func _ensure() -> bool:
	if _expr == null:
		_expr = Expression.new()
		var err := _expr.parse(code, inputs)
		if err != OK:
			push_error("Expression parse error: %s" % _expr.get_error_text())
			return false
	return true

func do() -> bool:
	var did_win := false
	#handle confusione
	if agent.is_confused :
		agent.is_confused = false
		if  randi_range(0,1) ==0:
			agent.hp -= CONFUSION_DMG
			return WHOWON.TARGET
	
	_exec([agent, target])
	
	if target.hp <= 0:
		did_win = true
	
	return false

func _exec(args:Array, base:Variant = null) -> Variant:
	if not _ensure():
		return null
	var res = _expr.execute(args, base, true)
	return res
