extends Node2D

@onready var worker = preload("res://unit/worker.tscn")
@onready var soilder = preload("res://unit/soldier.tscn")
var housePos = Vector2(300, 300)

var tpyeOfSpawnUI :String

func setSpawnType(type:String):
	tpyeOfSpawnUI = type
func _ready() -> void:
	pass
func _on_bt_yes_pressed() -> void:
	var rng = RandomNumberGenerator.new()
	var randomPosX = rng.randi_range(-50, 50)
	var randomPosY = rng.randi_range(-50, 50)
	var uniPath = get_tree().get_root().get_node("main_world/Units")
	var worldPath = get_tree().get_root().get_node("main_world")
	var unit1
	match tpyeOfSpawnUI:
		"house":
			unit1 = worker.instantiate()
		"camp":
			unit1 = soilder.instantiate()
	if unit1 != null:
		unit1.position = housePos + Vector2(randomPosX, randomPosY)
	uniPath.add_child(unit1)
	worldPath.get_units()

func _on_bt_no_pressed() -> void:
	var housePath = get_tree().get_root().get_node("main_world/buildings")
	for i in housePath.get_child_count():
		if housePath.get_child(i).Selected:
			housePath.get_child(i).Selected = false
	queue_free()
