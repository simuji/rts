extends StaticBody2D

var totalTime = 5
var currentTime 
var units = 0
var mouseEntered = false

@onready var bar = $HealthPointProgressBar
@onready var curMousePosition 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentTime = totalTime
	bar.max_value = totalTime
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bar.value = currentTime
	if currentTime <= 0:
		pass

func _on_area_2d_mouse_entered() -> void:
	Game.setMouseTarget(self)

func _on_area_2d_mouse_exited() -> void:
	Game.setMouseTarget(null)
