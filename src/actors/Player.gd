extends Actor
class_name Player

export var coyote_time: float = 0.0

onready var ball: PackedScene = preload("res://src/objects/GhostBall.tscn")

var direction: Vector2 = Vector2.ZERO
var face_dir setget _set_face_dir, _get_face_dir
var was_in_air = false

func _physics_process(_delta: float) -> void:
	direction = get_direction()

	var jumping = direction.y < 0 and can_jump()

	if jumping:
		_jump()

	var snap: = Vector2.DOWN * 60.0 if not jumping else Vector2.ZERO

	_velocity = Vector2(
		speed.x * direction.x,
		speed.y * direction.y if jumping else _velocity.y
	)

	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)

	if was_in_air and is_on_floor():
		_land()

	if is_on_floor() or is_on_wall():
		$CoyoteTime.start(coyote_time)

	was_in_air = !is_on_floor()

	if Input.is_action_just_pressed("interact"):
		_interact()

	self.face_dir = direction.x

func can_jump() -> bool:
	return (
		is_on_floor() or
		is_on_wall() or
		$CoyoteTime.time_left > 0
	)

func _land() -> void:
	$AnimationPlayer.play("land")

func _jump() -> void:
	$CoyoteTime.stop()
	$AnimationPlayer.play("jump")

func _interact() -> void:
	var inst: Ball = ball.instance()
	inst.global_position = global_position + Vector2(32, -32)
	inst.linear_velocity = Vector2(300.0, -500.0)
	inst.add_central_force(Vector2(0.0, 981.0))
	get_parent().add_child(inst)

func _set_face_dir(x: float) -> void:
	if x != 0:
		$Face.scale.x = sign(x)

func _get_face_dir() -> float:
	return sign($Face.scale.x)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") -
		Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") else 0.0
	)
