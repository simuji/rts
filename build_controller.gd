extends Node2D

@onready var grid = $Grid 

const camp = preload("res://building/camp.tscn")
const house = preload("res://building/house.tscn")

var gridSize: Vector2
var object
var targetCell
var objectCells 
var isValid = false
var isBuilding = false

func _ready() -> void:
	gridSize = Vector2(grid.cellWidth, grid.cellHeight)
	Game.setBuildController(self)

func _exit_tree() -> void:
	Game.setBuildController(null)

func build(buildType: String):
	if not object:
		var newBuilding = null
		match buildType:
			"camp":
				newBuilding = camp.instantiate()
			"house":
				newBuilding = house.instantiate()
		if newBuilding == null:
			return
		add_child(newBuilding)
		newBuilding.global_position = get_global_mouse_position()
		object = newBuilding
		isBuilding = true
		grid.visible = true
	
func _input(event: InputEvent):
	if  Input.is_action_just_pressed("Left_Click") and isValid and isBuilding:
		_place_placement(objectCells)
		isBuilding = false
		grid.visible = false

func _process(delta: float) -> void:
	if not object: return
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
