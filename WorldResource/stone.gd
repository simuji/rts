extends "res://WorldResource/game_resourse.gd"
func _ready() -> void:
	super._ready()
	resourcedata = DataManager.getResourceList()[GameDataConstants.ResourceTypeEnum.STONE]
