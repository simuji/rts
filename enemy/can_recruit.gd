extends ConditionLeaf
@export var unitType: GameDataConstants.UnitTypeEnum
@export var maxUnitNum: int
func tick(actor: Node, blackboard: Blackboard) -> int:
	var farction: Farction
	var num_of_unit: int = 0

	if blackboard.has_value("farction"):
		farction = blackboard.get_value("farction")
	for unit in farction.spawnedUnitList:
		if unit.unitType == unitType:
			num_of_unit += 1
	if num_of_unit >= maxUnitNum:
		return FAILURE
	return SUCCESS
		
