extends TextureButton

@onready var textureRect:TextureRect = $textureRect
@onready var worker = preload("res://unit/worker.tscn")
@onready var soilder = preload("res://unit/soldier.tscn")
@onready var descriptionUI = $UnitDescriptionUI
var housePos = Vector2(300, 300)
var unitSpawnData: UnitSpawnData
func _ready() -> void:
	print("ready")
	textureRect = $textureRect
func _on_pressed() -> void:
	var rng = RandomNumberGenerator.new()
	var randomPosX = rng.randi_range(-50, 50)
	var randomPosY = rng.randi_range(-50, 50)
	var uniPath = get_tree().get_root().get_node("main_world/Units")
	var worldPath = get_tree().get_root().get_node("main_world")
	var unit
	
	if (DataManager.getPopulation() < unitSpawnData.getPopulationCost()):
		return
	if Game.getFocusBuilding() == null:
		return
	DataManager.setPopulation(DataManager.getPopulation() -\
		 unitSpawnData.getPopulationCost())
	match unitSpawnData.getUnitType():
		GameDataConstants.UnitTypeEnum.WORKER:
			unit = worker.instantiate()
		GameDataConstants.UnitTypeEnum.SOILDER:
			unit = soilder.instantiate()
	if unit != null:
		unit.position = Game.getFocusBuilding().position + Vector2(randomPosX, randomPosY)
	uniPath.add_child(unit)
	unit.setfraction(Game.getFocusBuilding().attribute.farction)
	worldPath.get_units()
	
func setRecruitData(data: UnitSpawnData):
	unitSpawnData = data
	textureRect.texture = data.getUnitIcon()


func _on_mouse_entered() -> void:
	descriptionUI.visible = true

func _on_mouse_exited() -> void:
	descriptionUI.visible = false
