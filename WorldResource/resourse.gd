extends StaticBody2D

@export var resourcedata: ResourceData

var totalTime = 5
var currentTime 
var units = 0
var mouseEntered = false
var bPlaced: bool = false
@onready var sprite = $Sprite2D
@onready var bar = $HealthPointProgressBar
@onready var attributeComponent = $AttributeComponent
@onready var curMousePosition 
@export var rect: Rect2
@export var isPreBuild: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentTime = totalTime
	bar.max_value = totalTime
	attributeComponent.Destroyed.connect(_on_destroy)
	if isPreBuild:
		if (int(rect.size.x) / 32 % 2 == 0):
			global_position.x = round(global_position.x / 32) * 32
		else:
			global_position.x = round(global_position.x / 32) * 32 + 16
		if (int(rect.size.y) / 32 % 2 == 0):
			global_position.y = round(global_position.y / 32) * 32
		else:
			global_position.y = round(global_position.y / 32) * 32 + 16 
		call_deferred("addResource")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_area_2d_mouse_entered() -> void:
	Game.setMouseTarget(self)

func _on_area_2d_mouse_exited() -> void:
	Game.setMouseTarget(null)
	
func _on_destroy():
	if resourcedata:
		DataManager.itemDataManager.obtain_resource(resourcedata.getReward())
	queue_free()
	
func get_global_rect() -> Rect2:
	return Rect2(
		Vector2(global_position.x - rect.size.x/2, global_position.y - rect.size.y/2),
		rect.size
	)
func addResource():
	Game.addBuildingPlaced(self)
func set_on_place():
	sprite.modulate.a = 255
