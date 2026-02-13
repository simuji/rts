extends ActionLeaf
var ticks = 0
func tick(actor: Node, blackboard: Blackboard) -> int:
	var farction: Farction
	if blackboard.has_value("farction"):
		farction = blackboard.get_value("farction")
	var rng = RandomNumberGenerator.new()
	var randomPosX = rng.randi_range(0, 500)
	var randomPosY = rng.randi_range(0, 500)
	for unit in farction.spawnedUnitList:
		if ticks % 10 == 0:
			unit.setTarget(Vector2(randomPosX,randomPosY), null)
	ticks += 1
	return SUCCESS
