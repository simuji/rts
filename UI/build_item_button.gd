extends TextureButton
class_name BuildItemButton
var buildType: GameDataConstants.BuildingTypeEnum
var buildData: BuildingSpawnData
@onready var textureRect:TextureRect = $TextureRect
@onready var descriptionUI = $BuildingDescriptionUI
func _on_pressed() -> void:
	var buildController: BuildController = PlayerController.getBuildController()
	if buildController:
		print("startBuild")
		buildData.setFarction(PlayerController.currentFarctionEnum)
		buildController.buildByPlayer(buildData);

func setBuildData(data: BuildingSpawnData):
	buildData = data
	buildType = data.buildType
	textureRect.texture = data.buildIcon

func _on_mouse_entered() -> void:
	print("show description")
	descriptionUI.visible = true


func _on_mouse_exited() -> void:
	print("dishow description")
	descriptionUI.visible = false
