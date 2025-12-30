extends Node

class UnitStateMachine:
	enum UnitState {
		IDLE,
		WALK,
		ATTACK,
		ATTACKED,
		DEATH
	}
	var current_state: UnitState = UnitState.IDLE
	var valid_transitions: Dictionary = {          # 合法状态切换映射
		UnitState.IDLE: [UnitState.WALK, UnitState.ATTACK, UnitState.ATTACKED, UnitState.DEATH],
		UnitState.WALK: [UnitState.IDLE, UnitState.ATTACK, UnitState.ATTACKED, UnitState.DEATH],
		UnitState.ATTACK: [UnitState.IDLE, UnitState.WALK, UnitState.ATTACKED, UnitState.DEATH],
		UnitState.ATTACKED: [UnitState.IDLE, UnitState.WALK, UnitState.ATTACK, UnitState.DEATH],
		UnitState.DEATH: []  # 死亡状态不可切换到任何状态
	}
	func _init() -> void:
		pass
	func get_current_state() -> UnitState:
		return current_state
		
	func change_state(target_state: UnitState) -> bool:
		#切换角色状态（对外核心控制接口）
		#param target_state: 目标状态（UnitState 枚举值）
		#return: 是否切换成功
		# 1. 校验状态切换合法性
		if not is_state_transition_valid(target_state):
			print("无法从 %s 切换到 %s" % [UnitState.keys()[current_state], UnitState.keys()[target_state]])
			return false
		# 3. 更新当前状态
		current_state = target_state
		print("状态切换：%s -> %s" % [UnitState.keys()[current_state], UnitState.keys()[target_state]])
		return true
	
	func is_state_transition_valid(target_state: UnitState) -> bool:
		# 1. 检查目标状态是否在合法切换列表中
		return target_state in valid_transitions[current_state]
