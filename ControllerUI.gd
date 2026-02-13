extends CanvasLayer
class_name ControllerUI
var technologyUIResource = preload("res://UI/TecnologyUI.tscn")
var technologyUI
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerController.setGameUI(self)
	technologyUI = technologyUIResource.instantiate()
	add_child(technologyUI)
	technologyUI.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_2_pressed() -> void:
	print("press button 2")
	var buildController = PlayerController.getBuildController()
	if buildController:
		buildController.build("camp")

func _on_button_pressed() -> void:
	print("press button")
	var buildController = PlayerController.getBuildController()
	if buildController:
		buildController.build("house")

func _on_technology_button_pressed():
	technologyUI.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		technologyUI.visible = false
