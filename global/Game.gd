extends Node

@onready var spawn = preload("res://spawn_ui.tscn")
var Wood = 0
var Stone = 0
var curMouseTarget: Object = null
var m_buildController = null

var currentFarctionEnum : GameDataConstants.FarctionEnum = GameDataConstants.FarctionEnum.PLAYER1 
#游戏中所有建筑列表
var buildingList: Dictionary[int, BuildingSpawnData] = {}
#当前可放置建筑
var availableBuildingList: Dictionary[int, BuildingSpawnData] = {}
#游戏中的个体
var unitList: Dictionary[int, UnitSpawnData] = {}
#游戏中所有物品列表
var itemList: Dictionary[int, ItemData] = {}
#仓库中物品列表
var currentItemlList: Dictionary[int, ItemData] = {}

var gameUI : CanvasLayer

#保存游戏地图中所有建筑
var buildingPlaced: Array[Object]
#保存游戏中所有的招募单位
#保存游戏地图中所有的资源
var resourcePlaced: Array[Object]

func _ready() -> void:
	pass
	#buildingList[0] = "house"
	#buildingList[1] = "camp"
	#availableBuildingList[0] = "house"
	#availableBuildingList[1] = "camp"
func  spawnUnit(pos, spawntpye:String):
	var path = get_tree().get_root().get_node("main_world/UI")
	var hasSpawn = false
	for i in path.get_child_count():
		if "spawn_ui" == path.get_child(1).name:
			hasSpawn = true
	if hasSpawn == false:
		var spawnUnit = spawn.instantiate()
		spawnUnit.housePos = pos
		spawnUnit.setSpawnType(spawntpye)
		path.add_child(spawnUnit)

func setMouseTarget(mouseTarget: Object):
	if mouseTarget != null:
		print("set curMouseTarget:" + mouseTarget.name)
	curMouseTarget = mouseTarget
	
func getMouseTarget() -> Object:
	return curMouseTarget


func setBuildController(buildController):
	m_buildController = buildController 
func getBuildController():
	return m_buildController

func addAvailableBuilding(key:int):
	if (buildingList.find_key(key)):
		availableBuildingList[key] = buildingList[key]
func getAvailableBuildingList() -> Dictionary[int, BuildingSpawnData]:
	return availableBuildingList
#获取可放置单位列表
func setUnitList(list:Dictionary[int, UnitSpawnData]):
	unitList = list
#设置可放置单位列表
func getUnitList():
	return unitList

func setGameUI(ui : CanvasLayer) :
	gameUI = ui

func getBuildMenu() -> TextureRect:
	if gameUI:
		return gameUI.find_child("BuildMenu")
	return null

func addBuildingPlaced(obj):
	buildingPlaced.push_back(obj)
func eraseBuildingPlaced(obj):
	buildingPlaced.erase(obj)
	
