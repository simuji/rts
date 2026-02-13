extends Node
class_name Farction
var farctionName: String
var farctionType: FarctionInfo.FarctionTypeEnum
var color: Color
var centerLocation: Vector2

var enemyBehaveTree: Node
var spawnedBuildingList: Array[Building]
var spawnedUnitList: Array[Unit]
#人口数
var population: int
#最大人口数
var maxPopulation: int

var money: int

#所有可用的放置单位
var unitSpawnList: Dictionary[int, UnitSpawnData]
#当前建筑能够放置的单位
var availableUnitSpawnList: Array[int]

var buildingSpawnList: Dictionary[int, BuildingSpawnData]

var resourceList: Dictionary[int, ResourceData]
#物品信息
var gameItemList: Dictionary[int, ItemData_]
var currentItemList: Dictionary[int, int] = {}
#当前阵容的单位
var unitList: Dictionary[int, UnitSpawnData] = {}
#科技树 todo
#当前可放置建筑
var availableBuildingList: Dictionary[int, BuildingSpawnData] = {}

var itemDataManager: DataManager.ItemDataManager
func init() -> void:
	print("init farction")
	itemDataManager = DataManager.ItemDataManager.new()
	
	unitSpawnList[GameDataConstants.UnitTypeEnum.WORKER] = DataManager.workerSpawnData
	unitSpawnList[GameDataConstants.UnitTypeEnum.SOILDER] = DataManager.soilderSpawnData
	unitSpawnList[GameDataConstants.UnitTypeEnum.ARCHOR] = DataManager.archerSpawnData
	
	buildingSpawnList[GameDataConstants.BuildingTypeEnum.HOUSE] = DataManager.houseSpawnData
	buildingSpawnList[GameDataConstants.BuildingTypeEnum.CAMP] = DataManager.campSpawnData
	
	gameItemList[GameDataConstants.ItemTypeEnum.WOOD] = DataManager.wood
	gameItemList[GameDataConstants.ItemTypeEnum.STONE] = DataManager.stone 
	
	currentItemList[GameDataConstants.ItemTypeEnum.WOOD] = 100
	currentItemList[GameDataConstants.ItemTypeEnum.STONE] = 100
	
	resourceList[GameDataConstants.ResourceTypeEnum.TREE] = DataManager.treeResource
	resourceList[GameDataConstants.ResourceTypeEnum.STONE] = DataManager.stoneResource
	
	maxPopulation = 100
	population = 60
	
	money = 0
func getUnitSpawnList() -> Dictionary[int, UnitSpawnData]:
	return unitSpawnList

func setavailableUnitSpawnList(list: Array[int]):
	print("set unit", list)
	availableUnitSpawnList = list
func getAvailableUnitSpawnList() -> Array[UnitSpawnData]:
	var list: Array[UnitSpawnData]
	print("find unit", availableUnitSpawnList, unitSpawnList)
	availableUnitSpawnList.sort_custom(func(a,b): return a < b)
	for i in availableUnitSpawnList:
		if unitSpawnList.has(i):
			print(i)
			list.push_back(unitSpawnList[i])
	return list

func getAvailableBuildingList() -> Array[BuildingSpawnData]:
	var list: Array[BuildingSpawnData]
	for key in buildingSpawnList.keys():
		if buildingSpawnList[key].canBuild:
			list.push_back(buildingSpawnList[key])
	return list

func getCurrentItemList() -> Dictionary[int, int]:
	return currentItemList

func getItemList() -> Dictionary[int, ItemData_]:
	return gameItemList
func getResourceList() -> Dictionary[int, ResourceData]:
	return resourceList
func setResourceList(list: Dictionary[int, ResourceData]):
	resourceList = list
func setPopulation(value: int):
	value = clamp(value, 0, maxPopulation)
	population = value	
func getPopulation() -> int:
	return population
func setMaxPopulation(value: int):
	value = clamp(value, 0, 99999)
	maxPopulation = value	
func getMaxPopulation() -> int:
	return maxPopulation
func getMoney() -> int:
	return money
func setMoney(value: int):
	value = clamp(value, 0, 99999)
	money = value
