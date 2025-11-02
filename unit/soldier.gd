extends "res://unit/unit.gd"

@onready var anim = get_node("AnimationPlayer")

func _process(delta: float) -> void:
	if bTargetInArea && arrive:
		if "house" in currentTargetString:
			anim.play("soldier_attack")
		if "camp" in currentTargetString:
			anim.play("soldier_attack")
	elif abs(velocity.x) + abs(velocity.y) > 0:
		anim.play("soldier_walk")
	else:
		anim.play("soldier_idle")
