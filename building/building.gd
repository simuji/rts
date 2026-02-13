extends StaticBody2D
class_name Building
var mouseEntered = false
@export var buildingData : BuildingSpawnData
@onready var selectBox = get_node("SelectedBox")
@onready var attributeComponent:AttributeComponent = $AttributeComponent
@export var rect: Rect2
@export var isPreBuild: bool
var Selected = false
@onready var sprite = $Sprite2D
@onready var attribute:AttributeComponent = $AttributeComponent
@onready var healthbar:HealthPointProgressBar = $HealthPointProgressBar
@onready var objectType: GameDataConstants.ObjectTypeEnum
var farctionName: String
var usableUnitList: Array[int] = [0, 1, 2]
var bPlaced: bool = false
var farctionColor: Color
var buildingType: GameDataConstants.BuildingTypeEnum
func _ready() -> void:
	print("build init")
	selectBox.visible = false
	usableUnitList = [0, 1 ,2]
	attributeComponent.Destroyed.connect(_on_destroy)
	if isPreBuild:
		print("adjust")
		if (int(rect.size.x) / 64 % 2 == 0):
			global_position.x = round(global_position.x / 64) * 64
		else:
			global_position.x = round(global_position.x / 64) * 64 + 32
		if (int(rect.size.y) / 64 % 2 == 0):
			global_position.y = round(global_position.y / 64) * 64
		else:
			global_position.y = round(global_position.y / 64) * 64 + 32 
		call_deferred("addBuilding")
	objectType = GameDataConstants.ObjectTypeEnum.BUILDING
	print("set color", farctionColor.h)
	var shader: ShaderMaterial = sprite.material
	print("color hue",shader.get_shader_parameter("target_hue_center"))
	var newShader = shader.duplicate(true)
	newShader.set_shader_parameter("target_hue_center", farctionColor.h)
	sprite.material = newShader
	SceneController.gameController.farctions[farctionName].spawnedBuildingList.append(self)
	
	attribute.farction = farctionName
	healthbar.setProgressBarColor(farctionName)
	
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	mouseEntered = true
	pass
	#Game.setMouseTarget(self)
func _on_area_2d_mouse_exited() -> void:
	mouseEntered = false
	pass
	#Game.setMouseTarget(null)

func _on_destroy():
	SceneController.gameController.farctions[farctionName].spawnedBuildingList.erase(self)
	queue_free()
	
func get_global_rect() -> Rect2:
	return Rect2(
		Vector2(global_position.x - rect.size.x/2, global_position.y - rect.size.y/2),
		rect.size
	)

func set_on_place():
	sprite.modulate.a = 255

func addBuilding():
	PlayerController.addBuildingPlaced(self)
	
func setfraction(farction: String):
	if attribute:
		print("setfarction", farction)
		attribute.farction = farction
		healthbar.setProgressBarColor(farction)
	else:
		farctionName = farction
	pass
func setColor(color:Color):
	print("set color")
	farctionColor = color
func selectBuilding(bSelected: bool) -> void:
	Selected = bSelected
	selectBox.visible = bSelected

func _exit_tree() -> void:
	PlayerController.getBuildController().clean_cell(get_global_rect())
