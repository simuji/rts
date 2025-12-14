extends Node

class_name Technology

enum TechnologyType {
	TOOL,
	FIRE,
	MONEY,
	Weapon,
	Smelt
}

var type: TechnologyType
var cost: Dictionary[GameDataConstants.ItemTypeEnum, int]
#解锁花费时间
var time: float
#是否可以研究
var canResearch: bool = false
var bResarched: bool = false
var Prerequisite: Array[int]
var technologyIcon: Texture2D
