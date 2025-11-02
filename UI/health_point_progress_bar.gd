extends ProgressBar

var attributeComponent: Object = null

func _ready() -> void:
	attributeComponent = get_parent().find_child("AttributeComponent")
	print(attributeComponent.name, get_parent().name)
	if attributeComponent != null:
		print("attribute component is not null")
		attributeComponent.HealthChanged.connect(on_health_changed);
	
func on_health_changed(oldHealthPoint:float, newHealthPoint: float):
	print("on health change", self.get_parent().name)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", newHealthPoint, 0.3).set_trans(tween.TRANS_LINEAR)
	
