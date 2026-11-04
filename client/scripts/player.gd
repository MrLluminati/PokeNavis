extends CharacterBody2D

@export var move_speed: float = 96.0
var movement_locked := false


func _physics_process(_delta: float) -> void:
	if movement_locked:
		velocity = Vector2.ZERO
		return
	var axis := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Horizontal wins a simultaneous two-axis press. Velocity is always cardinal.
	var direction := Vector2.ZERO
	if not is_zero_approx(axis.x):
		direction.x = signf(axis.x)
	elif not is_zero_approx(axis.y):
		direction.y = signf(axis.y)
	velocity = direction * move_speed
	move_and_slide()
