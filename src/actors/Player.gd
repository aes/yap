extends Actor


func _physics_process(_delta: float) -> void:
	var direction: = get_direction()

	_velocity = calculate_move_velocity(_velocity, direction, speed)

	var snap: = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO

	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	if is_on_wall():
		modulate = Color(10, 10, 10, 1)
	else:
		modulate = Color(1, 1, 1, 1)


func get_direction() -> Vector2:
	var jump = (
		(is_on_floor() or is_on_wall()) and
		 Input.is_action_just_pressed("jump")
	)
	return Vector2(
		Input.get_action_strength("move_right") -
		Input.get_action_strength("move_left"),
		-1.0 if jump else 0.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	return velocity
