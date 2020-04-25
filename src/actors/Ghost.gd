extends Player

var original: Player
var mirrored: = false


func _ready() -> void:
	original = get_node_or_null("../Player")

func _land() -> void:
	pass

func get_direction() -> Vector2:
	if not original:
		return Vector2.ZERO
	var dir = original.direction
	if mirrored:
		dir.x = -dir.x
	return dir
