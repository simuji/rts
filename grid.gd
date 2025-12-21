@tool
extends Node2D
var tilemap : TileMapLayer

@export var width := 5:
	set(value):
		width = value
		#_remove_grid()
		#_create_grid()
@export var height := 5:
	set(value):
		height = value
		#_remove_grid()
		#_create_grid()
@export var cellWidth := 100:
	set(value):
		cellWidth = value
		#_remove_grid()
		#_create_grid()
@export var cellHeight := 100:
	set(value):
		cellHeight = value
		#_remove_grid()
		#_create_grid()

const  GridCell = preload("res://UI/GridCell.tscn")
const borderSize = 4

func _ready() -> void:
	tilemap = get_parent().get_parent().get_node("NavigationRegion2D").get_node("TileMapLayer")
	_remove_grid()
	#_create_grid()
	visitTileMap()

func _create_grid():
	for i in width * height:
		var gridCellNode = GridCell.instantiate()
		gridCellNode.custom_minimum_size = Vector2(cellWidth, cellHeight)
		add_child(gridCellNode.duplicate())
	

func _remove_grid():
	for node in get_children():
		node.queue_free()

func visitTileMap():
	var layer_tiles = {}
	# 2. 获取该图层的所有瓦片坐标（仅非空瓦片）
	var tile_coords: Array[Vector2i] = tilemap.get_used_cells()
	var arrayX: Array[int]
	var arrayY: Array[int]
	for c in tile_coords:
		arrayX.push_back(c.x)
		arrayY.push_back(c.y)
	for vector in tile_coords:
		print(vector)
		var data : TileData = tilemap.get_cell_tile_data(vector)
		if data.has_custom_data("canUse") and data.get_custom_data("canUse"):
			var gridCellNode = GridCell.instantiate()
			gridCellNode.custom_minimum_size = Vector2(cellWidth, cellHeight)
			gridCellNode.position.x = vector.x * cellWidth
			gridCellNode.position.y = vector.y * cellHeight
			add_child(gridCellNode.duplicate())
			print(gridCellNode.position)
