extends "res://unit/unit.gd"

@onready var anim = get_node("AnimationPlayer")

func _process(delta: float) -> void:
	if bTargetInArea && arrive:
		print(attack)
		if "house" in currentTargetString:
			anim.play("attack")
		if "camp" in currentTargetString:
			anim.play("attack")
		if "worker" in currentTargetString:
			anim.play("attack")
	elif abs(velocity.x) + abs(velocity.y) > 0:
		anim.play("walk")
	else:
		anim.play("idle")

func attack():
	var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
	damageinfo.setDamageCount(10)
	damageinfo.setSource(self)
	damageinfo.setTarget(currentTarget)
	DamageController.SendDamageMessage(damageinfo)
