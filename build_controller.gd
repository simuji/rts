extends Node2D

class_name BuildController
@onready var grid = $grid

var camp
var house
var gridSize: Vector2
var object
var targetCell
var objectCells 
var isValid = false
var isBuilding = false

var buildData: BuildingSpawnData

func _ready() -> void:
	camp = load("res://building/camp.tscn")
	house = load("res://building/house.tscn")
	gridSize = Vector2(grid.cellWidth, grid.cellHeight)
	print("setbuild controller")
	call_deferred("setController")
	PlayerController.setBuildController(self)
	SceneController.setBuildController(self)
func _exit_tree() -> void:
	PlayerController.setBuildController(null)

func buildByPlayer(data: BuildingSpawnData):
	print("start build")
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
		newBuilding.setfraction(data.getFarction())
		object = newBuilding
		isBuilding = true
		grid.visible = true

func buildByCompute(data: BuildingSpawnData) -> bool:
	print("start build")
	if !data:
		return false
	var local_buildData = data
	var newBuilding:Building = null
	print("startbuild-111",str(local_buildData.buildType))
	match local_buildData.buildType:
		GameDataConstants.BuildingTypeEnum.CAMP:
			if !DataManager.itemDataManager.isHasEnoughItem(local_buildData.buildCost):
				return false
			newBuilding = camp.instantiate()
		GameDataConstants.BuildingTypeEnum.HOUSE:
			if !DataManager.itemDataManager.isHasEnoughItem(local_buildData.buildCost):
				return false
			newBuilding = house.instantiate()
	if newBuilding == null:
		return false
	
	var x = randi_range(-100, 100)
	var y =randi_range(-100,100)
	var rand_position = Vector2(x,y) + local_buildData.buildPosition
	var newTargetCell = _get_target_cell(rand_position)
	print("farction:", local_buildData.getFarction())
	newBuilding.setfraction(local_buildData.getFarction())
	newBuilding.setColor(SceneController.gameController.farctions[local_buildData.getFarction()].color)
	if newTargetCell and newTargetCell != targetCell:
		targetCell = newTargetCell
		newBuilding.global_position = targetCell.global_position + newBuilding.rect.size/2
		_reset_highlight()
				
	var objectCells: Array = []
	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(newBuilding.get_global_rect()):
			objectCells.append(child)
	var local_is_vaild = true
	var objectCellCount = (newBuilding.rect.size.x / gridSize.x) * (newBuilding.rect.size.y / gridSize.y)
	if objectCellCount != objectCells.size():
		local_is_vaild = false
	for cell in objectCells:
		if cell.full:
			local_is_vaild = false
	if local_is_vaild:
		print("is vaild")
		add_child(newBuilding)
		newBuilding.set_on_place()
		#do_placement(newBuilding)
		newBuilding = null
		for cell in objectCells:
			cell.full = true
		_reset_highlight()
		return true
	else:
		return false

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

func clean_cell(rect: Rect2):
	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(rect):
			child.full = false
