extends Node2D
class_name EasyEnemy
@onready var beehaveTree:BeehaveTree = $BeehaveTree
var farction: Farction

func _ready() -> void:
	print("easy enemy init")
	beehaveTree.blackboard.set_value("farction",farction)
	
