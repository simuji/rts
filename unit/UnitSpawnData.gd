extends Resource
# unit data
class_name UnitSpawnData

#士兵类型
@export var unitType: GameDataConstants.UnitTypeEnum
#士兵图标
@export	var unitIcon: Texture2D
@export	var unitIconPath: String
@export	var unitObjectPath : String
@export var populationCost: int
@export	var unitItemCost: Dictionary[GameDataConstants.ItemTypeEnum,int]
@export	var canRecruit:bool

func getUnitType() -> GameDataConstants.UnitTypeEnum:
	return unitType
func setUnitType(type: GameDataConstants.UnitTypeEnum):
	unitType = type
func getUnitIcon() -> Texture2D:
	return unitIcon
func setUnitIcon(icon: Texture2D):
	unitIcon = icon
func getUnitIconPath() -> String:
	return unitIconPath
func setUnitIconPath(path: String):
	unitIconPath = path
func isUnitCanRecruit() -> bool:
	return canRecruit
func setUnitCanRecruit(value: bool):
	canRecruit = value
func getPopulationCost() -> int:
	return populationCost
func setPopulationCost(value: int):
	populationCost = value
