extends Resource

class_name BuildingSpawnData
#建筑类型
@export	var buildType: GameDataConstants.BuildingTypeEnum
#物品图标
@export	var buildIcon: Texture2D
@export	var buildIconPath: String
@export	var buildObjectPath : String
@export	var buildCost: Dictionary[GameDataConstants.ItemTypeEnum,int]
@export	var canBuild:bool
#建筑生产物品的列表，key是物品类型，value是生产速率，单位为个/秒
@export	var productionList: Dictionary[GameDataConstants.ItemTypeEnum,int]
#人口增加速率，单位: 人/每单位时间
@export var populationIncreaseSpeed: int
@export var maxPopulationIncreased: int
@export var farction: String
@export var buildPosition: Vector2
func getBuildType() -> GameDataConstants.BuildingTypeEnum:
	return buildType
func setBuildType(type: GameDataConstants.BuildingTypeEnum):
	buildType = type
func getBuildIcon() -> Texture2D:
	return buildIcon
func setBuildIcon(icon: Texture2D):
	buildIcon = icon
func getBuildIconPath() -> String:
	return buildIconPath
func setBuildIconPath(path: String):
	buildIconPath = path
func isBuildingCanBuild() -> bool:
	return canBuild
func setBuildingCanBuild(value: bool):
	canBuild = value
func getProductionList() -> Dictionary[GameDataConstants.ItemTypeEnum,int]:
	return productionList
func setProductionList(list: Dictionary[GameDataConstants.ItemTypeEnum,int]):
	productionList = list
func getFarction() -> String:
	return farction
func setFarction(value: String):
	farction = value
func setBuildPosition(position: Vector2):
	buildPosition = position
func getBuildPosition() -> Vector2:
	return buildPosition
	
