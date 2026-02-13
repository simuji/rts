extends "res://building/building.gd"
class_name House

var populationIncreasedSpeed: int
@onready var timer = $Timer
func _ready() -> void:
	super._ready()
	buildingType = GameDataConstants.BuildingTypeEnum.HOUSE
	buildingData = DataManager.buildingSpawnList[buildingType]
	populationIncreasedSpeed = buildingData.populationIncreaseSpeed
	if farctionName == PlayerController.currentFarctionEnum:
		DataManager.setMaxPopulation(DataManager.getMaxPopulation() + \
			buildingData.maxPopulationIncreased)
	else:
		var farc = SceneController.gameController.farctions[farctionName] 
		farc.setMaxPopulation(farc.getMaxPopulation() + buildingData.maxPopulationIncreased)
		
func _on_timer_timeout() -> void:
	if farctionName == PlayerController.currentFarctionEnum:
		DataManager.setPopulation(DataManager.getPopulation() + \
			populationIncreasedSpeed)
	else:
		var farc = SceneController.gameController.farctions[farctionName] 
		farc.setPopulation(farc.getPopulation() + populationIncreasedSpeed)
func _to_string() -> String:
	return "house"
