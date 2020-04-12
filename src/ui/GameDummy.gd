extends Node2D


func _ready() -> void:
	GlobalGameState.reset()


func _physics_process(delta: float) -> void:
	$Sprite.rotation_degrees += delta * 90.0


func pause() -> void:
	$GameHUD/Control/PauseOverlay.paused = true


func score() -> void:
	GlobalGameState.score += 100
