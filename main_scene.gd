extends Node2D

@onready var visible_window: ColorRect = $VisibleWindow
@onready var button: Button = $VisibleWindow/VBoxContainer/Button
@onready var label: Label = $VisibleWindow/VBoxContainer/Label

func _ready() -> void:
	button.pressed.connect(func(): label.text = str(randi_range(0, 2000)))

func _process(delta: float) -> void:
	
	set_passthrough()
	pass

func set_passthrough():
	if not is_inside_tree():
		await ready
	var settings_size:Vector2 = Vector2(ProjectSettings.get(&"display/window/size/viewport_width"), ProjectSettings.get(&"display/window/size/viewport_height"))
	var real_size: Vector2 = DisplayServer.window_get_size()
	var size_factor: Vector2 = real_size / settings_size

	var control_window:Rect2 = visible_window.get_rect()
	var texture_corners: PackedVector2Array = [
		(control_window.position) * size_factor,
		(control_window.position + control_window.size * Vector2.RIGHT) * size_factor,
		(control_window.end) * size_factor,
		(control_window.position + control_window.size * Vector2.DOWN) * size_factor
	]
	DisplayServer.window_set_mouse_passthrough(texture_corners)
