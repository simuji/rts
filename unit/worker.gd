extends "res://unit/unit.gd"
class_name Worker
var isChopping = false
var isMining = false
@onready var anim = get_node("AnimationPlayer")
@onready var animTree = $AnimationTree
@onready var animation_state = animTree.get("parameters/playback")

func _ready() -> void:
	super._ready()
	unitType = GameDataConstants.UnitTypeEnum.WORKER

func arrive():
	if "tree" in currentTargetString:
		changeUnitState(UnitState.CHOP)
	elif "stone" in currentTargetString:
		changeUnitState(UnitState.MINE)
	else:
		changeUnitState(UnitState.IDLE)
func chop():
	var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
	if is_instance_valid(currentTarget):
		damageinfo.setDamageCount(10)
		damageinfo.setSource(self)
		damageinfo.setTarget(currentTarget)
		DamageController.SendDamageMessage(damageinfo)
	else:
		#目标消亡，寻找下一个目标，或者停止行动
		changeUnitState(UnitState.IDLE)
func mine():
	if is_instance_valid(currentTarget):
		var damageinfo: DamageController.DamageInfo = DamageController.DamageInfo.new()
		damageinfo.setDamageCount(10)
		damageinfo.setSource(self)
		damageinfo.setTarget(currentTarget)
		DamageController.SendDamageMessage(damageinfo)
	else:
		#目标消亡，寻找下一个目标，或者停止行动
		changeUnitState(UnitState.IDLE)
		
func _on_attacked_finished():
	changeUnitState(oldUnitState)

func died():
	queue_free()

func changeUnitState(state: UnitState):
	super.changeUnitState(state)
	match state:
		UnitState.IDLE:
			print("unit state change to IDLE")
			animTree.set("parameters/conditions/idle", true)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
			animTree.set("parameters/conditions/mine", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/chop", false)
		UnitState.WALK:
			print("unit state change to WALK")
			animTree.set("parameters/conditions/walk", true)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
			animTree.set("parameters/conditions/chop", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/mine", false)
		UnitState.CHOP:
			print("unit state change to CHOP")
			animTree.set("parameters/conditions/chop", true)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/mine", false)
		UnitState.MINE:
			print("unit state change to MINE")
			animTree.set("parameters/conditions/mine", true)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/dying", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/chop", false)
		UnitState.ATTACKED:
			print("unit state change to attacked")
			animTree.set("parameters/conditions/attacked", true)
			animTree.set("parameters/conditions/dying", false)
			animTree.set("parameters/conditions/mine", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/chop", false)
		UnitState.DYING:
			print("unit state change to DYING")
			animTree.set("parameters/conditions/dying", true)
			animTree.set("parameters/conditions/attacked", false)
			animTree.set("parameters/conditions/mine", false)
			animTree.set("parameters/conditions/walk", false)
			animTree.set("parameters/conditions/idle", false)
			animTree.set("parameters/conditions/chop", false)
func _to_string() -> String:
	return "worker"
