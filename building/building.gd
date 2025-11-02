extends StaticBody2D

var mouseEntered = false
@onready var select = get_node("SelectedBox")
@onready var attributeComponent = $AttributeComponent
var Selected = false
func _ready() -> void:
	attributeComponent.Destroyed.connect(_on_destroy)
	pass

func _process(delta: float) -> void:
	select.visible = Selected
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		if mouseEntered == true:
			Selected = !Selected
			if Selected == true:
				pass
			Game.spawnUnit(global_position, self.name)

func _on_area_2d_mouse_entered() -> void:
	mouseEntered = true
	Game.setMouseTarget(self)
func _on_area_2d_mouse_exited() -> void:
	mouseEntered = false
	Game.setMouseTarget(null)

func _on_destroy():
	queue_free()
