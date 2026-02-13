extends Control
class_name MainMenu
@onready var startButton = $StartButton
@onready var farctionContainer = $FarctionContainer
func _on_button_pressed() -> void:
	print("开始游戏");
	# 隐藏按钮防止重复点击
	$StartButton.disabled = true
	var farctions: Array[FarctionInfo]
	for item in farctionContainer.get_children():
		if item.farctionType != FarctionInfo.FarctionTypeEnum.NONE:
			var farction = FarctionInfo.new()
			farction.farctionName = ""
			farction.farctionType = item.farctionType
			farction.color = item.colorSelector.get_selected_color()
			farctions.append(farction)
	# 开始异步加载
	await SceneController.load_game_scene_async("res://main_world.tscn", farctions)
