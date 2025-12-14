extends "res://building/building.gd"

var buildingType = GameDataConstants.BuildingTypeEnum.HOUSE
var populationIncreasedSpeed: int
@onready var timer = $Timer
func _ready() -> void:
	super._ready()
	buildingData = DataManager.buildingSpawnList[buildingType]
	populationIncreasedSpeed = buildingData.populationIncreaseSpeed
	if buildingData.getFarction() == Game.currentFarctionEnum:
		DataManager.setMaxPopulation(DataManager.getMaxPopulation() + \
			buildingData.maxPopulationIncreased)

func _on_timer_timeout() -> void:
	if buildingData.getFarction() == Game.currentFarctionEnum:
		DataManager.setPopulation(DataManager.getPopulation() + \
			populationIncreasedSpeed)
