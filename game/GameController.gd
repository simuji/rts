extends Node
class_name GameController
var farctionInfos: Array[FarctionInfo]
var farctions: Dictionary[String, Farction]
var easyEnemy = preload("res://enemy/EasyEnemy.tscn")
var hardEnemy = preload("res://enemy/EasyEnemy.tscn")
var mainBaseScene
@export var startPointArrary: Array[Vector2]

func _init() -> void:
	print("init")
	mainBaseScene = load("res://building/mainBase.tscn")
	SceneController.gameController = self
	
func setFarctionInfos(input_farctions: Array[FarctionInfo]):
	print("GameController: set farction")
	farctionInfos = input_farctions
func addFarctionInfos(input_farction: FarctionInfo):
	farctionInfos.append(input_farction)
func getFarctionInfos() -> Array[FarctionInfo]:
	return farctionInfos
	
func startGame():
	print(startGame)
	var index : int = 0
	startPointArrary.shuffle()
	for farctionInfo in farctionInfos:
		var farction = Farction.new()
		farction.name = farctionInfo.farctionName
		farction.color = farctionInfo.color
		farction.farctionType = farctionInfo.farctionType
		generateEnemyBeehaveTree(farction, index)
		index += 1
		farctions[farctionInfo.farctionName] = farction
	var farction = Farction.new()
	farction.name = "player1"
	farctions[farction.name] = farction
	PlayerController.centerlocation = startPointArrary[index]
	PlayerController.currentFarctionEnum = "player1"
	PlayerController.genearateMainBase()
		
func generateEnemyBeehaveTree(farction: Farction, index: int):		
	var beehaveTree: EasyEnemy
	match farction.farctionType:
		FarctionInfo.FarctionTypeEnum.EASY_COMPUTE:
			beehaveTree = easyEnemy.instantiate()
			farction.enemyBehaveTree = beehaveTree
			print("gamecontroller: add beehavetree",get_parent().name)
			get_parent().add_child.call_deferred(beehaveTree)
		FarctionInfo.FarctionTypeEnum.HARD_COMPUTE:
			beehaveTree = hardEnemy.instantiate()
			farction.enemyBehaveTree = beehaveTree
			print("gamecontroller: add beehavetree")
			get_parent().add_child.call_deferred(beehaveTree)
	farction.centerLocation = startPointArrary[index]
	beehaveTree.farction = farction
	farction.init()
	var mainBase:Building = mainBaseScene.instantiate()
	mainBase.position = farction.centerLocation
	mainBase.isPreBuild = true
	get_parent().add_child.call_deferred(mainBase)
	mainBase.setColor(farction.color)
