extends StaticBody2D

var mouseEntered = false
@export var buildingData : BuildingSpawnData
@onready var select = get_node("SelectedBox")
@onready var attributeComponent = $AttributeComponent
@export var rect: Rect2
@export var isPreBuild: bool
var Selected = false
@onready var sprite = $Sprite2D

var unitList: Array[int] = [0, 1, 2]
var bPlaced: bool = false
func _ready() -> void:
	print("build init")
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
	
func _process(delta: float) -> void:
	select.visible = Selected
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		if mouseEntered == true:
			Selected = !Selected
			if Selected == true:
				pass
			#Game.spawnUnit(global_position, self.name)
			#切换到招募ui
			DataManager.setavailableUnitSpawnList(unitList)
			var ui = Game.getBuildMenu()
			if ui:
				ui.changeToRecruitUI()
func _on_area_2d_mouse_entered() -> void:
	mouseEntered = true
	Game.setMouseTarget(self)
func _on_area_2d_mouse_exited() -> void:
	mouseEntered = false
	Game.setMouseTarget(null)

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
	Game.addBuildingPlaced(self)
