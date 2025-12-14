extends Control

var resourceItemUI = preload("res://UI/ResourceItem.tscn")
@onready var populationText = $TextureRect/HBoxContainer/PopulationText
@onready var maxPopulationText = $TextureRect/HBoxContainer/MaxPopulationText
@onready var grid : GridContainer = $TextureRect/GridContainer
@onready var moneyText = $TextureRect/MoneyText
func _ready() -> void:
	updataItemUI()
	DataManager.itemDataManager.ItemDataChanged.connect(updataItemUI)
	
func _process(delta: float) -> void:
	moneyText.text = str(DataManager.getMoney())
	populationText.text = str(DataManager.getPopulation())
	
func updataItemUI():
	var currentitemList = DataManager.getCurrentItemList()
	var itemList = DataManager.getItemList()
	clearGrid()
	for itemIndex : int in currentitemList:
		var item = resourceItemUI.instantiate()
		var itemData = itemList[itemIndex]
		grid.add_child(item)
		item.setItemIcon(itemData.getItemIcon())
		item.setItemCount(currentitemList[itemIndex])
func clearGrid():
	for child in grid.get_children():
		grid.remove_child(child)
