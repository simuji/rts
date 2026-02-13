extends Node

class_name AttributeComponent
@export var healthPoint: float = 100.0
@export var maxHealthPoint: float = 100.0
#建造花费
@export var cost: Dictionary = {}
@export var attack: float = 0.0

#阵营
@export var farction: String
#@export var farction: GameDataConstants.FarctionEnum = GameDataConstants.FarctionEnum.NEUTRAL

signal Destroyed()
signal HealthChanged(oldHealthPoint: float, newHealthPoint: float)
signal Attcked(oldHealthPoint: float, newHealthPoint: float)
func _init() -> void:
	healthPoint = maxHealthPoint

func _ready() -> void:
	print("connect damage signal")
	DamageController.hit.connect(_on_take_damage)

func _on_take_damage(damageInfo: DamageController.DamageInfo):
	#print("take damage", get_parent().name)
	if damageInfo.getTarget() != self.get_parent():
		return
	var oldhealthPoint = healthPoint
	healthPoint = max(healthPoint - damageInfo.getDamageCount(), 0)
	print("old health is", oldhealthPoint, "new health is", healthPoint)
	if healthPoint != oldhealthPoint:
		HealthChanged.emit(oldhealthPoint, healthPoint)
		Attcked.emit(oldhealthPoint, healthPoint)
	if healthPoint <= 0:
		print("emit destroy")
		Destroyed.emit()
	
