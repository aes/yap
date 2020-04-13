extends Label

export var label_format: String = "Score: %d"


func _ready() -> void:
	var err = GlobalGameState.connect("score_updated", self, "score_updated")
	if err != OK:
		print("Error connecting to score_updated: ", err)


func score_updated(score: int) -> void:
	text = label_format % score
