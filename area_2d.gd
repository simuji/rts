extends Area2D

@onready var camera = get_viewport().get_camera_2d()

func _process(delta):
	# 让Area2D跟随鼠标位置
	global_position = camera.get_global_mouse_position()
	
	# 获取覆盖的所有物体（二选一）
	var overlapping_bodies = get_overlapping_bodies() # 检测PhysicsBody2D（如CharacterBody2D）
	var overlapping_areas = get_overlapping_areas()   # 检测Area2D
	
	if overlapping_bodies:
		pass
	elif overlapping_areas:
		if overlapping_areas[0].get_parent() != PlayerController.getMouseTarget():
			print("鼠标下的物理体：", overlapping_areas[0].get_parent().to_string())
			PlayerController.setMouseTarget(overlapping_areas[0].get_parent())
	else:
		if PlayerController.getMouseTarget() != null:
			print("鼠标下的物理体：空")
			PlayerController.setMouseTarget(null)
