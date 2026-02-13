extends ActionLeaf

@export var recruitUnitType: GameDataConstants.UnitTypeEnum
var worker
var soilder
func _init() -> void:
	worker = load("res://unit/worker.tscn")
	soilder = load("res://unit/soldier.tscn")
	
func tick(actor: Node, blackboard: Blackboard) -> int:
	var farction: Farction
	if blackboard.has_value("farction"):
		farction = blackboard.get_value("farction")
	var building = farction.spawnedBuildingList[0]
	var rng = RandomNumberGenerator.new()
	var randomPosX = rng.randi_range(-50, 50)
	var randomPosY = rng.randi_range(-50, 50)
	var uniPath = get_tree().get_root().get_node("main_world/Units")
	var worldPath = get_tree().get_root().get_node("main_world")
	var unit: Unit
	match recruitUnitType:
		GameDataConstants.UnitTypeEnum.WORKER:
			unit = worker.instantiate()
		GameDataConstants.UnitTypeEnum.SOILDER:
			unit = soilder.instantiate()
	var unitSpawnData = null
	unitSpawnData =  farction.unitSpawnList[recruitUnitType]
	if (farction.getPopulation() < unitSpawnData.getPopulationCost()):
		return SUCCESS
	
	farction.setPopulation(farction.getPopulation() -\
		 unitSpawnData.getPopulationCost())
	
	if unit != null:
		unit.position = building.position + Vector2(randomPosX, randomPosY)
	unit.farction = farction.farctionName
	uniPath.add_child(unit)
	unit.setfraction(farction.farctionName)
	return SUCCESS
