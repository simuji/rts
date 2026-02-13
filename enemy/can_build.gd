extends ConditionLeaf

@export var buildType: GameDataConstants.BuildingTypeEnum 
@export var maxBuildNum: int

func tick(actor: Node, blackboard: Blackboard) -> int:
	var farction: Farction
	var num_of_building: int = 0
	if blackboard.has_value("farction"):
		farction = blackboard.get_value("farction")
	for building in farction.spawnedBuildingList:
		if building.buildingType == buildType:
			num_of_building += 1
	print("num of buld:", num_of_building)
	if num_of_building >= maxBuildNum:
		return FAILURE
	return SUCCESS
