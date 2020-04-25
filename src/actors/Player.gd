extends Actor
class_name Player

export var coyote_time: float = 0.0

var direction: Vector2 = Vector2.ZERO
var was_in_air = false

func _physics_process(_delta: float) -> void:
	direction = get_direction()

	var snap: = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO

	_velocity = calculate_move_velocity(_velocity, direction, speed)

	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	
	if was_in_air and is_on_floor():
		_land()

	if is_on_floor() or is_on_wall():
		$CoyoteTime.start(coyote_time)

	was_in_air = !is_on_floor()


func can_jump() -> bool:
	return (
		is_on_floor() or
		is_on_wall() or
		$CoyoteTime.time_left > 0
	)

func _land() -> void:
	$AnimationPlayer.play("land")
	$AudioCrash.play()

func _jump() -> void:
	$CoyoteTime.stop()
	$AnimationPlayer.play("jump")


func get_direction() -> Vector2:
	var jump = Input.is_action_just_pressed("jump") and can_jump()

	if jump:
		_jump()

	return Vector2(
		Input.get_action_strength("move_right") -
		Input.get_action_strength("move_left"),
		-1.0 if jump else 0.0
	)


func calculate_move_velocity(
		velocity: Vector2,
		dir: Vector2,
		speed: Vector2
) -> Vector2:
	var out: = velocity

	out.x = speed.x * dir.x

	if dir.y != 0.0:
		out.y = speed.y * dir.y

	return out
