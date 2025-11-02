extends Node2D

var workers = []

func _ready() -> void:
	get_units()
func get_units():
	workers = null
	workers = get_tree().get_nodes_in_group("Units");
func _on_area_selected(object):
	var start = object.start
	var end = object.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	for u in workers: 
		u.set_selected(false)
	for u in units_in_area: 
		u.set_selected(!u.selected)
	
func get_units_in_area(area):
	var u = []
	for worker in workers:
		if (worker.position.x > area[0].x) and (worker.position.x < area[1].x):
			if (worker.position.y > area[0].y) and (worker.position.y < area[1].y):
				u.append(worker)
	return u
