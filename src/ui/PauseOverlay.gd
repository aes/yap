extends Popup

var paused: = false setget set_paused


func _ready() -> void:
	paused = get_tree().paused
	pause_mode = Node.PAUSE_MODE_PROCESS


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		get_tree().set_input_as_handled()


func set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = value

	if paused:
		show_modal(true)
	else:
		hide()


func _on_resume_pressed() -> void:
	self.paused = false


func _on_tree_exiting() -> void:
	self.paused = false


func _on_restart_pressed() -> void:
	self.paused = false
	var err = get_tree().reload_current_scene()
	if err != OK:
		print("Failed to reload_current_scene: ", err)
