extends Ball

func _on_timeout() -> void:
	var ghost: = load("res://src/actors/Ghost.tscn")
	var inst: Actor = ghost.instance()
	inst.global_position = global_position
	get_parent().add_child(inst)
	queue_free()
