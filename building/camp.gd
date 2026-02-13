extends "res://building/building.gd"
class_name Camp
func _ready() -> void:
	super._ready()
	buildingType = GameDataConstants.BuildingTypeEnum.CAMP
	#unitList[1] = "solider"
func _to_string() -> String:
	return "camp"
