@tool
extends GridContainer

@export var width := 5:
	set(value):
		width = value
		_remove_grid()
		_create_grid()
@export var height := 5:
	set(value):
		height = value
		_remove_grid()
		_create_grid()
@export var cellWidth := 100:
	set(value):
		cellWidth = value
		_remove_grid()
		_create_grid()
@export var cellHeight := 100:
	set(value):
		cellHeight = value
		_remove_grid()
		_create_grid()

const  GridCell = preload("res://UI/GridCell.tscn")
const borderSize = 4

func _ready() -> void:
	_remove_grid()
	_create_grid()

func _create_grid():
	columns = width
	
	for i in width * height:
		print(i)
		var gridCellNode = GridCell.instantiate()
		gridCellNode.custom_minimum_size = Vector2(cellWidth, cellHeight)
		add_child(gridCellNode.duplicate())
	

func _remove_grid():
	for node in get_children():
		node.queue_free()
