tool
extends Button

export(String, FILE) var target_scene = ""


func _get_configuration_warning() -> String:
	if target_scene == "":
		return "Target Scene must refer to a scene resource path"

	return ""


func _on_pressed() -> void:
	var err = get_tree().change_scene(target_scene)
	if err != OK:
		print("Failed to change_scene: ", err)
