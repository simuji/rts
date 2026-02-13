extends Control
class_name ColorSelector
# 定义下拉框和颜色预览框的引用
@onready var color_dropdown = $VBoxContainer/HBoxContainer/OptionButton

# 预设颜色列表
var preset_colors = [
	Color(1, 0, 0),       # 红色
	Color(0, 1, 0),       # 绿色
	Color(0, 0, 1),       # 蓝色
	Color(1, 1, 0),       # 黄色
	Color(0.8, 0, 0.8),   # 紫色
	Color(1, 1, 1),       # 白色
	Color(0, 0, 0)        # 黑色
]

# 存储选中的颜色
var selected_color: Color = Color(1, 0, 0)

func _ready():
	# 清空默认选项
	color_dropdown.clear()
	
	# 用 add_icon_item 添加带颜色块的选项（无文字）
	init_color_icon_items()
	
	# 绑定选中事件
	color_dropdown.item_selected.connect(_on_color_selected)
	
	# 初始化默认选中第一个颜色
	color_dropdown.selected = 0
	
	# 更新下拉框按钮显示选中的色块
	update_dropdown_button_display(0)

# 核心：用 add_icon_item 创建颜色块选项
func init_color_icon_items():
	for color in preset_colors:
		# 1. 创建 ColorRect 作为颜色块
		var color_rect = ColorRect.new()
		color_rect.size = Vector2(60, 20)  # 色块大小
		color_rect.color = color
		# 添加边框（可选，提升辨识度）
		color_rect.add_theme_stylebox_override("normal", create_border_stylebox())
		
		# 2. 将 ColorRect 渲染为 Texture2D（关键步骤）
		var color_texture = render_control_to_texture(color)
		
		# 3. 添加图标项，文字传空字符串（只显示色块）
		color_dropdown.add_icon_item(color_texture, "")
		
# 将 Control 控件（ColorRect）渲染为 Texture2D
func render_control_to_texture(color: Color) -> Texture2D:
	var img = Image.create(256, 256, false, Image.FORMAT_RGBA8)
	img.resize(32,32)
	img.fill(color)
	var texture = ImageTexture.create_from_image(img)
	return texture

# 创建带边框的样式
func create_border_stylebox() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.border_color = Color(0.2, 0.2, 0.2)  # 灰色边框
	style.bg_color = Color(0, 0, 0, 0)        # 背景透明
	return style

# 选中颜色后的处理
func _on_color_selected(index: int):
	if index < 0 or index >= preset_colors.size():
		return
	
	# 更新选中颜色和预览框
	selected_color = preset_colors[index]

	# 更新下拉框按钮显示
	update_dropdown_button_display(index)
	
	# 调试输出
	print("选中颜色 RGB：", selected_color)

# 更新下拉框按钮的显示（显示选中的色块）
func update_dropdown_button_display(index: int):
	# 清空按钮原有文字
	color_dropdown.text = ""
	
	# 创建按钮显示用的色块纹理
	var display_rect = ColorRect.new()
	display_rect.size = Vector2(20, 20)
	display_rect.color = preset_colors[index]
	display_rect.add_theme_stylebox_override("normal", create_border_stylebox())
	var display_texture = render_control_to_texture(preset_colors[index])
	
	# 设置下拉框按钮的图标（替代文字）
	color_dropdown.icon = display_texture
	# 调整图标位置（可选，居中显示）
	color_dropdown.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER

# 获取选中的颜色（供外部调用）
func get_selected_color() -> Color:
	return selected_color
