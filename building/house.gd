extends "res://building/building.gd"

var buildingType = GameDataConstants.BuildingTypeEnum.HOUSE
var populationIncreasedSpeed: int
@onready var timer = $Timer
func _ready() -> void:
	super._ready()
	buildingData = DataManager.buildingSpawnList[buildingType]
	populationIncreasedSpeed = buildingData.populationIncreaseSpeed
	if buildingData.getFarction() == PlayerController.currentFarctionEnum:
		DataManager.setMaxPopulation(DataManager.getMaxPopulation() + \
			buildingData.maxPopulationIncreased)

func _on_timer_timeout() -> void:
	if buildingData.getFarction() == PlayerController.currentFarctionEnum:
		DataManager.setPopulation(DataManager.getPopulation() + \
			populationIncreasedSpeed)
func _to_string() -> String:
	return "house"
