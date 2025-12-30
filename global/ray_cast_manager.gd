extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
func _process(delta):
	# 让射线指向鼠标位置
	ray_cast.global_position = get_global_mouse_position()
	ray_cast.force_raycast_update() # 强制更新射线检测
	
	# 获取射线碰撞到的物体
	if ray_cast.is_colliding():
		var hovered_obj = ray_cast.get_collider()
		if Game.getMouseTarget() != hovered_obj:
			Game.setMouseTarget(hovered_obj)
		print("悬浮物体：", hovered_obj.name)
	else:
		if Game.getMouseTarget() != null:
			pass
			#Game.setMouseTarget(null)
