@tool
extends GridContainer
var tilemap:TileMap

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
	tilemap = get_parent().get_parent().get_node("NavigationRegion2D").get_node("TileMap")
	_remove_grid()
	_create_grid()

func _create_grid():
	columns = width
	for i in width * height:
		var gridCellNode = GridCell.instantiate()
		gridCellNode.custom_minimum_size = Vector2(cellWidth, cellHeight)
		add_child(gridCellNode.duplicate())
	

func _remove_grid():
	for node in get_children():
		node.queue_free()

func visitTileMap():
	# 1. 遍历所有图层
	for layer_idx in tilemap.get_layers_count():
		var layer_tiles = {}
		# 2. 获取该图层的所有瓦片坐标（仅非空瓦片）
		var tile_coords = tilemap.get_used_cells(layer_idx)
		
		# 3. 遍历每个瓦片坐标，获取瓦片数据
		for coord in tile_coords:
			# 核心：获取瓦片ID（-1为空）
			var tile_id = tilemap.get_cell_tile_id(layer_idx, coord)
			if tile_id == -1:
				continue
			
			# 可选：获取更多瓦片信息
			var tile_set = tilemap.tile_set  # 瓦片集
			var tile_source = tile_set.get_source_id_by_tile_id(tile_id)  # 瓦片源ID
			var tile_atlas_coords = tile_set.get_tile_atlas_coords(tile_source, tile_id)  # 图集坐标
			var tile_global_pos = tilemap.local_to_global(tilemap.map_to_local(coord))  # 全局像素坐标
			
