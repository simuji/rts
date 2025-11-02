extends "res://unit/unit.gd"

var isChopping = false
var isMining = false
@onready var anim = get_node("AnimationPlayer")

func _process(delta: float) -> void:
	if bTargetInArea && arrive:
		if "tree" in currentTargetString:
			anim.play("chop")
		if "stone" in currentTargetString:
			anim.play("mine")
	elif abs(velocity.x) + abs(velocity.y) > 0:
		anim.play("walk")
	else:
		anim.play("idle")

func chop():
	var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
	damageinfo.setDamageCount(10)
	damageinfo.setSource(self)
	damageinfo.setTarget(currentTarget)
	DamageController.SendDamageMessage(damageinfo)

func mine():
	var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
	damageinfo.setDamageCount(10)
	damageinfo.setSource(self)
	damageinfo.setTarget(currentTarget)
	DamageController.SendDamageMessage(damageinfo)
