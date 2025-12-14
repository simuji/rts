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
	var unit1
	
	if (DataManager.getPopulation() < unitSpawnData.getPopulationCost()):
		return
	DataManager.setPopulation(DataManager.getPopulation() -\
		 unitSpawnData.getPopulationCost())
	match unitSpawnData.getUnitType():
		GameDataConstants.UnitTypeEnum.WORKER:
			unit1 = worker.instantiate()
		GameDataConstants.UnitTypeEnum.SOILDER:
			unit1 = soilder.instantiate()
	if unit1 != null:
		unit1.position = housePos + Vector2(randomPosX, randomPosY)
	uniPath.add_child(unit1)
	worldPath.get_units()
	
func setRecruitData(data: UnitSpawnData):
	unitSpawnData = data
	textureRect.texture = data.getUnitIcon()


func _on_mouse_entered() -> void:
	descriptionUI.visible = true

func _on_mouse_exited() -> void:
	descriptionUI.visible = false
