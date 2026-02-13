extends Control

class_name FarctionSelectItem
@onready var farctionSelector = $HBoxContainer/factionSelector
@onready var colorSelector = $HBoxContainer/ColorSelector
@onready var farctionNmae = $HBoxContainer/farctionName
var farctionType: FarctionInfo.FarctionTypeEnum

func _ready() -> void:
	farctionSelector.item_selected.connect(_on_farction_type_selected);
	farctionSelector.add_item("无")
	farctionSelector.add_item("等待其他玩家加入")
	farctionSelector.add_item("简单的电脑敌人")
	farctionSelector.add_item("困难的电脑敌人")

func _on_farction_type_selected(index: int):
	match index:
		0:
			farctionType = FarctionInfo.FarctionTypeEnum.NONE
		1:
			farctionType = FarctionInfo.FarctionTypeEnum.PLAYER
		2:
			farctionType = FarctionInfo.FarctionTypeEnum.EASY_COMPUTE
			farctionNmae.text = "简单的电脑"
		3:
			farctionType = FarctionInfo.FarctionTypeEnum.HARD_COMPUTE
			farctionNmae.text = "困难的电脑"
