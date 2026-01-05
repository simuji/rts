extends Node2D

@onready var grid = $grid

const camp = preload("res://building/camp.tscn")
const house = preload("res://building/house.tscn")

var gridSize: Vector2
var object
var targetCell
var objectCells 
var isValid = false
var isBuilding = false

var buildData: BuildingSpawnData

func _ready() -> void:
	gridSize = Vector2(grid.cellWidth, grid.cellHeight)
	print("setbuild controller")
	call_deferred("setController")
	PlayerController.setBuildController(self)
func _exit_tree() -> void:
	PlayerController.setBuildController(null)

func build(data: BuildingSpawnData):
	if !data:
		return
	buildData = data
	if not object:
		var newBuilding = null
		print("startbuild-111",str(buildData.buildType))
		match buildData.buildType:
			GameDataConstants.BuildingTypeEnum.CAMP:
				if !DataManager.itemDataManager.isHasEnoughItem(buildData.buildCost):
					return
				newBuilding = camp.instantiate()
			GameDataConstants.BuildingTypeEnum.HOUSE:
				if !DataManager.itemDataManager.isHasEnoughItem(buildData.buildCost):
					return
				newBuilding = house.instantiate()
		if newBuilding == null:
			return
		add_child(newBuilding)
		newBuilding.global_position = get_global_mouse_position()
		newBuilding.setfraction(PlayerController.currentFarctionEnum)
		object = newBuilding
		isBuilding = true
		grid.visible = true
	
func _input(event: InputEvent):
	if  Input.is_action_just_pressed("Left_Click") and isValid and isBuilding:
		isBuilding = false
		grid.visible = false
		_place_placement(objectCells)
		DataManager.itemDataManager.consume_resource(buildData.buildCost)
	if Input.is_action_just_pressed("Right_Click") and isBuilding:
		object.queue_free()
		isBuilding = false
		grid.visible = false
		object = null
		isValid = null
func _process(delta: float) -> void:
	if not object: return
	for building in PlayerController.buildingPlaced:
		if !building.bPlaced:
			do_placement(building)
			building.bPlaced = true
	var mousePosition = get_global_mouse_position()
	var newTargetCell = _get_target_cell(mousePosition)
	if newTargetCell and newTargetCell != targetCell:
		targetCell = newTargetCell
		object.global_position = targetCell.global_position + object.rect.size/2
		_reset_highlight()
		
		objectCells = _get_object_cells()
		isValid = _check_and_hightlight_cells(objectCells)

func _get_target_cell(targetPosition):
	for child:Control in grid.get_children():
		if child.get_global_rect().has_point(targetPosition):
			return child
	
func _reset_highlight():
	for child:Control in grid.get_children():
		child.change_color(Color(0.5, 0.5, 0.5, 0.5))

func _get_object_cells() -> Array:
	var cells: Array = []
	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(object.get_global_rect()):
			cells.append(child)
	return cells

func _check_and_hightlight_cells(objectCells: Array) -> bool:
	var isValid = true
	var objectCellCount = (object.rect.size.x / gridSize.x) * (object.rect.size.y / gridSize.y)
	
	if objectCellCount != objectCells.size():
		isValid = false
	
	for cell in objectCells:
		if cell.full:
			isValid = false
			cell.change_color(Color.RED)
		else:
			cell.change_color(Color.GREEN)
	
	return isValid

func _place_placement(objectCells):
	object.set_on_place()
	object = null
	isValid = null
	for cell in objectCells:
		cell.full = true
	_reset_highlight()

func do_placement(obj):
	var cells: Array = []
	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(obj.get_global_rect()):
			cells.append(child)
	obj.set_on_place()
	obj = null
	for cell in cells:
		cell.full = true

func adjust_position(obj):
	var targetCell = _get_target_cell(obj.global_position)
	print(obj.global_position)
	if targetCell == null:
		return
	obj.global_position = targetCell.global_position + object.rect.size/2

func setController():
	PlayerController.setBuildController(self)
