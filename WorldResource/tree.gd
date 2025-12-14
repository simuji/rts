extends "res://WorldResource/resourse.gd"

func _ready() -> void:
	super._ready()
	resourcedata = DataManager.getResourceList()[GameDataConstants.ResourceTypeEnum.TREE]
