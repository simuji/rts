extends CharacterBody2D

@export var selected = false
@onready var selectedBox = get_node("SelectedBox")
@onready var sprite = get_node("body")

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target = position

@onready var searchedObjectMap: Dictionary #保存现在在unit的搜寻范围内的物体
@onready var attributeComponent = $AttributeComponent

var currentTarget: Object #保存当前unit的target
var currentTargetString: String
var bTargetInArea:bool = false
var DEFAULT_TARGET_DESIRE_DISTANCE = 15
var mouseEntered = false
var arrive = false #当前unit是否到达target
var follow_cursor = false
var speed = 40

func _ready() -> void:
	set_selected(selected)
	add_to_group("Units", true)
	attributeComponent.Destroyed.connect(_on_destroy)
func set_selected(value:bool):
	selectedBox.visible = value
	selected = value

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.

func  _input(event):
	if event.is_action_pressed("Right_Click"):
		follow_cursor = true
		if selected:
			currentTarget = Game.getMouseTarget()
			currentTargetString = currentTarget.to_string() if currentTarget != null else ""
			var target_navigation_obstacle = null
			var target_desired_distance = DEFAULT_TARGET_DESIRE_DISTANCE
			if currentTarget != null:
				target_navigation_obstacle = currentTarget.find_child("NavigationObstacle2D")
			if target_navigation_obstacle != null:
				target_desired_distance = target_navigation_obstacle.radius
				print("get target navigation obstacle:", target_navigation_obstacle.radius)
			else:
				target_desired_distance = DEFAULT_TARGET_DESIRE_DISTANCE
			navigation_agent.set_target_desired_distance(target_desired_distance + 10)
			print("target_desired_distance is ", navigation_agent.target_desired_distance)
			print("Current Target of this unit is" + currentTargetString)
			arrive = false
	if event.is_action_released("Right_Click"):
		follow_cursor = false 
		
func _physics_process(delta: float) -> void:
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
			navigation_agent.target_position = target
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var direction = to_local(next_path_position).normalized()
	velocity = direction * speed 
	if (velocity.x >= 0):
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	navigation_agent.set_velocity(velocity)
	

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity 
	move_and_slide()


func _on_navigation_agent_2d_navigation_finished() -> void:
	arrive = true
	print("arrive")
	pass # Replace with function body.
	
func _on_search_area_body_entered(body: Node2D) -> void:
	print(body.name + "entered search area, is string is" + body.to_string())
	searchedObjectMap[body.to_string()] = body.name
	if body.to_string() == currentTargetString:
		bTargetInArea = true
func _on_search_area_body_exited(body: Node2D) -> void:
	if searchedObjectMap.find_key(body.to_string()) != null:
		searchedObjectMap.erase(body.to_string())
	if body.to_string() == currentTargetString:
		print("target exit")
		bTargetInArea = false

func _on_destroy():
	queue_free()


func _on_click_area_2d_mouse_entered() -> void:
	mouseEntered = true
	Game.setMouseTarget(self)


func _on_click_area_2d_mouse_exited() -> void:
	mouseEntered = false
	Game.setMouseTarget(null)
