extends Node

@onready var spawn = preload("res://spawn_ui.tscn")
var Wood = 0
var Stone = 0
var curMouseTarget: Object = null
func  spawnUnit(pos, spawntpye:String):
	var path = get_tree().get_root().get_node("main_world/UI")
	var hasSpawn = false
	for i in path.get_child_count():
		if "spawn_ui" == path.get_child(1).name:
			hasSpawn = true
	if hasSpawn == false:
		var spawnUnit = spawn.instantiate()
		spawnUnit.housePos = pos
		spawnUnit.setSpawnType(spawntpye)
		path.add_child(spawnUnit)

func setMouseTarget(mouseTarget: Object):
	if mouseTarget != null:
		print("set curMouseTarget:" + mouseTarget.name)
	curMouseTarget = mouseTarget
	
func getMouseTarget() -> Object:
	return curMouseTarget
