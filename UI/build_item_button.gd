extends TextureButton

var buildType: GameDataConstants.BuildingTypeEnum
var buildData: BuildingSpawnData
@onready var textureRect:TextureRect = $TextureRect
@onready var descriptionUI = $BuildingDescriptionUI
func _on_pressed() -> void:
	var buildController = PlayerController.getBuildController()
	if buildController:
		print("startBuild")
		buildController.build(buildData);

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
