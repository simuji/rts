extends ProgressBar

var attributeComponent: Object = null

func _ready() -> void:
	attributeComponent = get_parent().find_child("AttributeComponent")
	if attributeComponent != null:
		attributeComponent.HealthChanged.connect(on_health_changed);
		setProgressBarColor(attributeComponent.farction)
func on_health_changed(oldHealthPoint:float, newHealthPoint: float):
	print("on health change", self.get_parent().name)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", newHealthPoint, 0.3).set_trans(tween.TRANS_LINEAR)
	
func setProgressBarColor(farctionEnum : GameDataConstants.FarctionEnum):
	if farctionEnum == GameDataConstants.FarctionEnum.NEUTRAL:
		print("中立单位")
		var progress_style = StyleBoxFlat.new()
		progress_style.bg_color = Color(1, 1, 0)  
		add_theme_stylebox_override("fill", progress_style)
	elif farctionEnum == PlayerController.currentFarctionEnum:
		print("友方单位")
		var progress_style = StyleBoxFlat.new()
		progress_style.bg_color = Color(0, 1, 0)  # 蓝色（RGB值范围 0-1）
		add_theme_stylebox_override("fill", progress_style)
	else:
		print("敌方单位")
		var progress_style = StyleBoxFlat.new()
		progress_style.bg_color = Color(1, 0, 0)  # 蓝色（RGB值范围 0-1）
		add_theme_stylebox_override("fill", progress_style)
	
