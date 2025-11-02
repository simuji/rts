extends StaticBody2D

func _on_mouse_exited() -> void:
	Game.setMouseTarget(null)

func _on_mouse_entered() -> void:
	Game.setMouseTarget(self)
