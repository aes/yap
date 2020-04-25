tool
extends Area2D

export(String) var target_portal = ""

var incoming = []


func _get_configuration_warning() -> String:
	var target = get_node_or_null("../" + target_portal)
	if target == null or target == self:
		return "Target Portal must refer to another portal"

	return ""


func _on_body_entered(body: KinematicBody2D) -> void:
	if incoming.find(body) >= 0:
		return

	var tgt: Area2D = get_node_or_null("../" + target_portal)
	body.global_position = tgt.global_position
	tgt.incoming.append(body)


func _on_body_exited(body: Node) -> void:
	incoming.erase(body)
