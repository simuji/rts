extends StaticBody2D

var mouseEntered = false
@export var buildingData : BuildingSpawnData
@onready var selectBox = get_node("SelectedBox")
@onready var attributeComponent = $AttributeComponent
@export var rect: Rect2
@export var isPreBuild: bool
var Selected = false
@onready var sprite = $Sprite2D
@onready var attribute = $AttributeComponent
@onready var healthbar = $HealthPointProgressBar
@onready var objectType: GameDataConstants.ObjectTypeEnum
var unitList: Array[int] = [0, 1, 2]
var bPlaced: bool = false
func _ready() -> void:
	print("build init")
	selectBox.visible = false
	unitList = [0, 1 ,2]
	attributeComponent.Destroyed.connect(_on_destroy)
	if isPreBuild:
		if (int(rect.size.x) / 32 % 2 == 0):
			global_position.x = round(global_position.x / 32) * 32
		else:
			global_position.x = round(global_position.x / 32) * 32 + 16
		if (int(rect.size.y) / 32 % 2 == 0):
			global_position.y = round(global_position.y / 32) * 32
		else:
			global_position.y = round(global_position.y / 32) * 32 + 16 
		call_deferred("addBuilding")
	objectType = GameDataConstants.ObjectTypeEnum.BUILDING
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
	
func setfraction(farction: GameDataConstants.FarctionEnum):
	attribute.farction = farction
	healthbar.setProgressBarColor(farction)
	pass
func selectBuilding(bSelected: bool) -> void:
	Selected = bSelected
	selectBox.visible = bSelected
