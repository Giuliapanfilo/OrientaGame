extends Resource
class_name Character
@export var dialogues : Array[DialogueResource]
@export_enum('sequence',  'random') var dialogue_cycle : int = 1
@export var name : String
@export var sprite : SpriteFrames
