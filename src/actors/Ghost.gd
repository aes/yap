extends Player

var original: Player
var mirrored: = false


func _ready() -> void:
	original = get_node_or_null("../Player")
	$AnimationPlayer2.play("ghost_in")
	$AudioCrash.volume_db = -20


func _interact() -> void:
	pass

func get_direction() -> Vector2:
	if not original:
		return Vector2.ZERO
	var dir = original.direction
	if mirrored:
		dir.x = -dir.x
	return dir
