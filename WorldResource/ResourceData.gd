extends Resource
class_name ResourceData

#资源类型
@export	var resourceType:  GameDataConstants.ResourceTypeEnum
#资源对象的路径
@export var resourceObjectPath : String
#破坏资源的奖励
@export var reward: Dictionary[GameDataConstants.ItemTypeEnum, int]

@export var healthPoint: float = 100.0
@export var maxHealthPoint: float = 100.0
#阵营
@export var farction: GameDataConstants.FarctionEnum = GameDataConstants.FarctionEnum.NEUTRAL

func getResourceType() -> GameDataConstants.ResourceTypeEnum:
	return resourceType
func setResourceType(type: GameDataConstants.ResourceTypeEnum):
	resourceType = type
func getResourceObjectPath() -> String:
	return resourceObjectPath
func setResourceObjectPath(path: String):
	resourceObjectPath = path
func getReward() -> Dictionary[GameDataConstants.ItemTypeEnum, int]:
	return reward
func setReward(dic :Dictionary[GameDataConstants.ItemTypeEnum, int]):
	reward = dic
