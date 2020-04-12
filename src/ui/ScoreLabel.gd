extends Label

export var label_format: String = "Score: %d"


func _ready() -> void:
	GlobalGameState.connect("score_updated", self, "score_updated")


func score_updated(score: int) -> void:
	text = label_format % score
