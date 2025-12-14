extends Control

@onready var icon_texture = $TextureRect/TextureRect2
@onready var itemCountText = $RichTextLabel
@onready var descriptionUI = $ItemDescriptionUI
func _ready() -> void:
	pass
	
func setItemIcon(texture : Texture2D):
	icon_texture.texture = texture

func setItemCount(count : int):
	itemCountText.text = str(count)	

func _on_mouse_entered() -> void:
	print("enter")
	descriptionUI.visible = true

func _on_mouse_exited() -> void:
	print("enter")
	descriptionUI.visible = false


func _on_texture_rect_mouse_entered() -> void:
	print("enter")
	descriptionUI.visible = true


func _on_texture_rect_mouse_exited() -> void:
	print("enter")
	descriptionUI.visible = false
