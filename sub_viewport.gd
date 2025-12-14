extends SubViewport

@onready var minimap_camera_node = $Camera2D
var main_world_camera_node : Camera2D

func _ready() -> void:
	world_2d = get_tree().root.world_2d
	main_world_camera_node = get_tree().root.get_child(4).get_child(1)
	
func _process(delta: float) -> void:
	minimap_camera_node.position = main_world_camera_node.position
