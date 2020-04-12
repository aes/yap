extends Node

signal score_updated(score)

var score: int = 0 setget set_score


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated", score)


func reset() -> void:
	self.score = 0
