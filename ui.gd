extends CanvasLayer

@onready var label = $ItemList/Label
@onready var label2 = $ItemList/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Wood: " + str(Game.Wood)
	label2.text = "Stone: " + str(Game.Stone)
