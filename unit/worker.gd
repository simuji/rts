extends "res://unit/unit.gd"

var isChopping = false
var isMining = false
@onready var anim = get_node("AnimationPlayer")

func _process(delta: float) -> void:
	if bTargetInArea && arrive:
		if "tree" in currentTargetString:
			anim.play("worker_chop")
		if "stone" in currentTargetString:
			anim.play("worker_mine")
	elif abs(velocity.x) + abs(velocity.y) > 0:
		anim.play("worker_walk")
	else:
		anim.play("worker_idle")
		
