extends Resource
class_name ItemData_
@export var itemName: String
#物品类型
@export var itemType: GameDataConstants.ItemTypeEnum
#物品图标
@export	var itemIcon: Texture2D
@export	var itemIconPath: String

func getItemName() -> String:
	return itemName
func setItemName(name: String):
	itemName = name
func getItemType() -> GameDataConstants.ItemTypeEnum:
	return itemType
func setItemType(type: GameDataConstants.ItemTypeEnum):
	itemType = type
func getItemIcon() -> Texture2D:
	return itemIcon
func setItemIcon(icon: Texture2D):
	itemIcon = icon
func getItemIconPath() -> String:
	return itemIconPath
func setItemIconPath(path: String):
	itemIconPath = path
