extends Node

signal hit(damageInfo: DamageInfo)
	
class DamageInfo:
	var m_damageCount: float
	var m_damageType: String
	var m_source: Object
	var m_target: Object
	
	func _init() -> void:
		m_damageCount = 0.0
		m_damageType = "CommanDamage"
		m_source = null
		m_target = null
	func getDamageCount() -> float:
		return m_damageCount	
	func setDamageCount(damageCount: float):
		m_damageCount = damageCount
	func getDamageType() -> String:
		return m_damageType	
	func setDamageType(damageType: String):
		m_damageType = damageType
	func getSource() -> Object:
		return m_source
	func setSource(source: Object):
		m_source = source
	func getTarget() -> Object:
		return m_target
	func setTarget(target: Object):
		m_target = target
		
func SendDamageMessage(damageInfo: DamageInfo):
	hit.emit(damageInfo)
	
