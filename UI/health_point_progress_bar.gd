extends ProgressBar

var attributeComponent: Object = null

func _ready() -> void:
	attributeComponent = get_parent().find_child("AttributeComponent")
	if attributeComponent != null:
		attributeComponent.HealthChanged.connect(on_health_changed);
	
func on_health_changed(oldHealthPoint:float, newHealthPoint: float):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", newHealthPoint, 0.3).set_trans(tween.TRANS_LINEAR)
	
