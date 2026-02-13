extends Node

@onready var spawn = preload("res://spawn_ui.tscn")
@onready var mainBaseScene = preload("res://building/mainBase.tscn")
var Wood = 0
var Stone = 0
var curMouseTarget: Object = null
var m_buildController: BuildController = null
var currentFarctionEnum: String = "player1" 
#var currentFarctionEnum : GameDataConstants.FarctionEnum = GameDataConstants.FarctionEnum.PLAYER1 
#游戏中所有建筑列表
var buildingList: Dictionary[int, BuildingSpawnData] = {}
var buildingTypeList: Array[String]
#当前可放置建筑
var availableBuildingList: Dictionary[int, BuildingSpawnData] = {}
#游戏中的个体
var unitList: Dictionary[int, UnitSpawnData] = {}
#游戏中所有物品列表
var itemList: Dictionary[int, ItemData_] = {}
#仓库中物品列表
var currentItemlList: Dictionary[int, ItemData_] = {}

var gameUI : CanvasLayer

#保存游戏地图中所有建筑
var buildingPlaced: Array[Object]
#保存游戏中所有的招募单位
#保存游戏地图中所有的资源
var resourcePlaced: Array[Object]
var focusBuilding: Object
var centerlocation: Vector2

signal TargetChanged(oldTarget, newTarget)

var units = []

func _ready() -> void:
	get_units()
	pass
	#buildingList[0] = "house"
	#buildingList[1] = "camp"
	#availableBuildingList[0] = "house"
	#availableBuildingList[1] = "camp"
	buildingTypeList = ["house", "camp"]
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		var ui = PlayerController.getBuildMenu()
		var hovered_ui = get_viewport().gui_get_hovered_control()
		if hovered_ui:
			return
		if !bTargetIsBuilding():
			if getFocusBuilding():
				getFocusBuilding().selectBuilding(false)
			setFocusBuilding(null)
			if ui:
				ui.changeToDefaultUI()
		else:
			#切换到招募ui
			if getFocusBuilding():
				getFocusBuilding().selectBuilding(false)
			if curMouseTarget.attribute.farction != PlayerController.currentFarctionEnum:
				return
			DataManager.setavailableUnitSpawnList(curMouseTarget.usableUnitList)
			if ui:
				ui.changeToRecruitUI()
			setFocusBuilding(curMouseTarget)
			getFocusBuilding().selectBuilding(true)
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
		print("set curMouseTarget:" + mouseTarget.to_string())
	if mouseTarget != curMouseTarget:
		print("target changed")
		TargetChanged.emit(curMouseTarget, mouseTarget);
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

func setFocusBuilding(building: Object):
	focusBuilding = building

func getFocusBuilding() -> Object:
	return focusBuilding

func bTargetIsBuilding() -> bool:
	if curMouseTarget == null:
		return false
	return curMouseTarget.objectType == GameDataConstants.ObjectTypeEnum.BUILDING

func genearateMainBase():
	var mainBase:Building = mainBaseScene.instantiate()
	print("123456", centerlocation)
	mainBase.position = centerlocation
	mainBase.setfraction(PlayerController.currentFarctionEnum)
	mainBase.isPreBuild = true
	buildingPlaced.append(mainBase)
	get_tree().current_scene.add_child.call_deferred(mainBase)


func get_units():
	units = []
	var allunits = get_tree().get_nodes_in_group("Units");
	for unit in allunits:
		if unit.attribute.farction == PlayerController.currentFarctionEnum:
			units.append(unit)
func _on_area_selected(object):
	get_units()
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	for u in units: 
		u.set_selected(false)
	for u in units_in_area: 
		u.set_selected(!u.selected)
	
func get_units_in_area(area):
	var u = []
	for worker in units.duplicate():
		if worker == null:
			continue
		if (worker.position.x > area[0].x) and (worker.position.x < area[1].x):
			if (worker.position.y > area[0].y) and (worker.position.y < area[1].y):
				u.append(worker)
	return u
