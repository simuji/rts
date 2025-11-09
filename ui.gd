extends CanvasLayer

@onready var label = $ItemList/HBoxContainer/Label2
@onready var label2 = $ItemList/HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Wood: " + str(Game.Wood)
	label2.text = "Stone: " + str(Game.Stone)


func _on_button_2_pressed() -> void:
	print("press button 2")
	var buildController = Game.getBuildController()
	if buildController:
		buildController.build("camp")

func _on_button_pressed() -> void:
	print("press button")
	var buildController = Game.getBuildController()
	if buildController:
		buildController.build("house")
