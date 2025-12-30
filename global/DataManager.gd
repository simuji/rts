extends Node2D

#unit spwan data
var workerSpawnData: UnitSpawnData = preload("res://unit/WorkerSpawnData.tres")
var soilderSpawnData: UnitSpawnData = preload("res://unit/SoilderSpawnData.tres")
var archerSpawnData: UnitSpawnData = preload("res://unit/archerSpawnData.tres")
#building spawn data
var houseSpawnData: BuildingSpawnData = preload("res://building/houseSpawnData.tres")
var campSpawnData: BuildingSpawnData = preload("res://building/campSpawnData.tres")

var wood: ItemData = preload("res://item/Wood.tres")
var stone: ItemData = preload("res://item/Stone.tres")

var treeResource: ResourceData = preload("res://WorldResource/treeResource.tres")
var stoneResource: ResourceData = preload("res://WorldResource/stoneResource.tres")
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
var gameItemList: Dictionary[int, ItemData]
var currentItemList: Dictionary[int, int]

var itemDataManager: ItemDataManager
#科技树 todo

func _ready() -> void:
	itemDataManager = ItemDataManager.new()
	unitSpawnList[GameDataConstants.UnitTypeEnum.WORKER] = workerSpawnData
	unitSpawnList[GameDataConstants.UnitTypeEnum.SOILDER] = soilderSpawnData
	unitSpawnList[GameDataConstants.UnitTypeEnum.ARCHOR] = archerSpawnData
	
	houseSpawnData.canBuild = true
	campSpawnData.canBuild = true
	buildingSpawnList[GameDataConstants.BuildingTypeEnum.HOUSE] = houseSpawnData
	buildingSpawnList[GameDataConstants.BuildingTypeEnum.CAMP] = campSpawnData
	
	gameItemList[GameDataConstants.ItemTypeEnum.WOOD] = wood
	gameItemList[GameDataConstants.ItemTypeEnum.STONE] = stone
	
	currentItemList[GameDataConstants.ItemTypeEnum.WOOD] = 100
	currentItemList[GameDataConstants.ItemTypeEnum.STONE] = 100
	
	resourceList[GameDataConstants.ResourceTypeEnum.TREE] = treeResource
	resourceList[GameDataConstants.ResourceTypeEnum.STONE] = stoneResource
	
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

func getItemList() -> Dictionary[int, ItemData]:
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
class ItemDataManager:
	signal ItemDataChanged
	func isHasEnoughItem(list: Dictionary[GameDataConstants.ItemTypeEnum, int]) -> bool:
		for itemKye in list:
			if !DataManager.currentItemList.has(itemKye) \
			 || DataManager.currentItemList[itemKye] < list[itemKye]:
				print("没有足够材料")
				return false
		return true
	func obtain_resource(list: Dictionary[GameDataConstants.ItemTypeEnum, int]): 
		for itemKye in list:
			if DataManager.currentItemList.has(itemKye):
				DataManager.currentItemList[itemKye] += list[itemKye]
			else:
				DataManager.currentItemList[itemKye] = list[itemKye]
		DataManager.currentItemList.sort()
		ItemDataChanged.emit()
		
	func consume_resource(list: Dictionary[GameDataConstants.ItemTypeEnum, int]):
		for itemKye in list:
			DataManager.currentItemList[itemKye] -= list[itemKye]
			if DataManager.currentItemList[itemKye] == 0:
				DataManager.currentItemList.erase(itemKye)
		DataManager.currentItemList.sort()
		ItemDataChanged.emit()
	
	
