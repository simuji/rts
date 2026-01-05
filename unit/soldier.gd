extends "res://unit/unit.gd"

@onready var anim = $"AnimationPlayer"
@onready var animTree = $AnimationTree
@onready var animation_state = animTree.get("parameters/playback")

func changeUnitState(state: UnitState):
	super.changeUnitState(state)
	match state:
		UnitState.IDLE:
			print("unit state change to IDLE")
			animTree.set("parameters/conditions/idle", true)
			animTree.set("parameters/conditions/attack", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
		UnitState.WALK:
			print("unit state change to WALK")
			animTree.set("parameters/conditions/walk", true)
			animTree.set("parameters/conditions/attack", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
		UnitState.ATTACK:
			print("unit state change to ATTACK")
			animTree.set("parameters/conditions/attack", true)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
		UnitState.ATTACKED:
			print("unit state change to ATTACKed")
			animTree.set("parameters/conditions/attacked", true)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/attack", false)
			animTree.set("parameters/conditions/dying", false)
		UnitState.DYING:
			print("unit state change to DYING")
			animTree.set("parameters/conditions/dying", true)
			animTree.set("parameters/conditions/attack", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/attacked", false)
func arrive():
	if "house" in currentTargetString or "camp" in currentTargetString\
		or "worker" in currentTargetString or "soilder" in currentTargetString:
			if currentTarget == self:
				changeUnitState(UnitState.IDLE)
				return
			if currentTarget.attribute.farction == self.attribute.farction:
				changeUnitState(UnitState.IDLE)
				return
			changeUnitState(UnitState.ATTACK)
	else:
		changeUnitState(UnitState.IDLE)
		
func _on_attacked_finished():
	changeUnitState(oldUnitState)
	
func died():
	queue_free()
	
func attack():
	if(currentTarget):
		var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
		damageinfo.setDamageCount(10)
		damageinfo.setSource(self)
		damageinfo.setTarget(currentTarget)
		DamageController.SendDamageMessage(damageinfo)
	else:
		#目标消亡，寻找下一个目标，或者停止行动
		changeUnitState(UnitState.IDLE)

func _to_string() -> String:
	return "soilder"
