extends TextureRect

@onready var buildMenuItem = preload("res://UI/BuildItemButton.tscn")
@onready var RecruitMenuItem = preload("res://UI/RecruitItemButton.tscn")
@onready var buidItemContainer: GridContainer = $buildItemContainer
@onready var tecnologyButton = $VBoxContainer/TecnologyButton #科技按钮
@onready var buildButton = $VBoxContainer/BuildButton #建造按钮
@onready var demolishButton = $VBoxContainer/DemolishButton #拆除按钮
@onready var ProductButton = $VBoxContainer/ProductButton #生产按钮
@onready var recruitButton = $VBoxContainer/RecruitButton #招募按钮

@onready var normalButtonTexture = preload("res://UI/buildMenuButton.png")
@onready var pressedButtonTexture = preload("res://UI/buildMenuButtonPressed2.png")

func _ready() -> void:
	pass

func _on_demolish_button_pressed() -> void:
	resetHighLightButton()
	demolishButton.texture_normal = pressedButtonTexture
	clearItemInGrid()
	
func _on_build_button_pressed() -> void:
	changeToBuildItem()
func _on_recruit_button_pressed() -> void:
	pass
	#changeToRecruitUI()
func _on_product_button_pressed() -> void:
	changeToProduceUI()
func _on_tecnology_button_pressed() -> void:
	changeToTecnologyUI()
	var main_ui = get_parent()
	if main_ui:
		main_ui._on_technology_button_pressed()
func changeToTecnologyUI():
	resetHighLightButton()
	clearItemInGrid()
func changeToBuildItem():
	resetHighLightButton()
	buildButton.texture_normal = pressedButtonTexture
	clearItemInGrid()
	for building in DataManager.getAvailableBuildingList():
		var item = buildMenuItem.instantiate()
		buidItemContainer.add_child(item)
		item.setBuildData(building);

func changeToRecruitUI() :
	resetHighLightButton()
	recruitButton.texture_normal = pressedButtonTexture
	clearItemInGrid()
	var spawnUnitList: Array[UnitSpawnData] = DataManager.getAvailableUnitSpawnList()
	for unit in spawnUnitList:
		var item = RecruitMenuItem.instantiate()
		buidItemContainer.add_child(item)
		item.setRecruitData(unit)
func changeToProduceUI():
	clearItemInGrid()
	resetHighLightButton()
	ProductButton.texture_normal = pressedButtonTexture

func clearItemInGrid():
	for child in buidItemContainer.get_children():
		child.queue_free()  # 延迟删除（推荐，避免即时删除导致的异常）
		# 或使用 child.free()（立即删除，可能有风险）

func resetHighLightButton():
	tecnologyButton.texture_normal = normalButtonTexture
	ProductButton.texture_normal = normalButtonTexture
	buildButton.texture_normal = normalButtonTexture
	recruitButton.texture_normal = normalButtonTexture
	demolishButton.texture_normal = normalButtonTexture
