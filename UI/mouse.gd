extends Node2D
class_name Mouse
@onready var sprite = $Sprite2D

var mouseNormalTexutre = preload("res://UI/MouseArrow.png")
var mouseAttackTexutre = preload("res://UI/MouseAttack.png")
var mouseSelectTexutre = preload("res://UI/mouseSelect.png")
var mouseCollectTexutre = preload("res://UI/mouseCollect.png")

func _ready() -> void:
	PlayerController.TargetChanged.connect(_on_target_change)
	
func _process(delta: float) -> void:
	position = get_global_mouse_position()

func _on_target_change(old_target, new_target):
	if new_target == null:
		sprite.texture = mouseNormalTexutre
		return
	if new_target.objectType == GameDataConstants.ObjectTypeEnum.BUILDING ||\
		new_target.objectType == GameDataConstants.ObjectTypeEnum.UNIT:
		if new_target.attribute != null && new_target.attribute.farction != PlayerController.currentFarctionEnum:
			sprite.texture = mouseAttackTexutre
		else:
			sprite.texture = mouseSelectTexutre
	elif new_target.objectType == GameDataConstants.ObjectTypeEnum.RESOURCE:
		sprite.texture = mouseCollectTexutre

		
