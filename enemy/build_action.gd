extends ActionLeaf
class_name BuildAction
@export var buildingType: GameDataConstants.BuildingTypeEnum
var count = 0
var tick_num = 0
func tick(actor: Node, blackboard: Blackboard) -> int:
	var farction: Farction
	if blackboard.has_value("farction"):
		farction = blackboard.get_value("farction")
	var buildController = SceneController.getBuildController()
	if buildController == null:
		print("controller is null")
		return SUCCESS
	var buildData:BuildingSpawnData = DataManager.buildingSpawnList[buildingType]
	buildData.buildPosition = farction.centerLocation
	buildData.farction = farction.farctionName
	var result:bool = buildController.buildByCompute(buildData)
	count += 1
	tick_num = 0
	if result == true:
		return SUCCESS
	return SUCCESS
