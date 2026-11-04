extends SceneTree

var failures := 0
var checks := 0


func _initialize() -> void:
	call_deferred("_run")


func _check(condition: bool, description: String) -> void:
	checks += 1
	if condition:
		print("PASS: ", description)
	else:
		failures += 1
		push_error("FAIL: " + description)


func _advance(frames: int) -> void:
	for index in frames:
		await physics_frame


func _run() -> void:
	_check(change_scene_to_file("res://scenes/world/test_village.tscn") == OK, "Village scene loads")
	await _advance(3)
	var village := current_scene
	var player: CharacterBody2D = village.get_node("Player")
	_check(player.position == Vector2(160, 448), "Village initial spawn is walkable")
	_check(player.get_node("Camera2D").limit_right == 1280, "Camera right limit matches map width")
	_check(player.get_node("Camera2D").limit_bottom == 896, "Camera bottom limit matches map height")
	var camera: Camera2D = player.get_node("Camera2D")
	_check(camera.get_screen_center_position().distance_to(Vector2(480, 448)) < 2, "Camera clamps at the left map edge")
	for action in ["move_left", "move_right", "move_up", "move_down"]:
		_check(InputMap.has_action(action) and InputMap.action_get_events(action).size() == 2, action + " has WASD and arrow bindings")
	var key_down := InputEventKey.new()
	key_down.physical_keycode = KEY_D
	key_down.pressed = true
	Input.parse_input_event(key_down)
	await _advance(2)
	_check(player.velocity == Vector2(96, 0), "Physical D key maps to right movement")
	key_down.pressed = false
	Input.parse_input_event(key_down)
	await _advance(2)
	var arrow_down := InputEventKey.new()
	arrow_down.physical_keycode = KEY_UP
	arrow_down.pressed = true
	Input.parse_input_event(arrow_down)
	await _advance(2)
	_check(player.velocity == Vector2(0, -96), "Up arrow maps to upward movement")
	arrow_down.pressed = false
	Input.parse_input_event(arrow_down)
	await _advance(2)
	player.position = Vector2(160, 448)

	Input.action_press("move_right")
	await _advance(10)
	Input.action_release("move_right")
	_check(player.position.x > 160 and is_equal_approx(player.position.y, 448.0), "Right input moves only horizontally")
	await _advance(2)
	_check(player.velocity == Vector2.ZERO, "Player stops when input is released")
	player.position = Vector2(640, 448)
	await _advance(3)
	_check(camera.get_screen_center_position().distance_to(Vector2(640, 448)) < 2, "Camera follows player inside the map")
	for test_case in [["move_left", Vector2(-96, 0)], ["move_up", Vector2(0, -96)], ["move_down", Vector2(0, 96)]]:
		Input.action_press(test_case[0])
		await _advance(2)
		_check(player.velocity == test_case[1], test_case[0] + " moves in the intended direction")
		Input.action_release(test_case[0])

	Input.action_press("move_right")
	Input.action_press("move_down")
	await _advance(2)
	_check(player.velocity == Vector2(96, 0), "Simultaneous axes choose one cardinal direction at 96 px/s")
	Input.action_release("move_right")
	Input.action_release("move_down")

	player.position = Vector2(170, 160)
	Input.action_press("move_right")
	await _advance(40)
	Input.action_release("move_right")
	_check(player.position.x <= 183.1, "Village building collider blocks movement")
	var wall_contact_y := player.position.y
	Input.action_press("move_up")
	await _advance(12)
	Input.action_release("move_up")
	_check(player.position.y < wall_contact_y and player.position.x <= 183.1, "Player can move along a blocker after contact")

	player.position = Vector2(56, 448)
	Input.action_press("move_left")
	await _advance(40)
	Input.action_release("move_left")
	_check(player.position.x >= 40.9, "Outer wall blocks leaving the map")
	player.position = Vector2(1140, 448)
	await _advance(3)
	_check(camera.get_screen_center_position().distance_to(Vector2(800, 448)) < 2, "Camera clamps at the right map edge")

	player.position = Vector2(1150, 448)
	Input.action_press("move_right")
	for index in 100:
		await physics_frame
		if current_scene != village:
			break
	Input.action_release("move_right")
	await _advance(3)
	_check(current_scene != village and current_scene.name == "TestRoute", "Village exit loads Route")
	var route := current_scene
	player = route.get_node("Player")
	_check(player.position.distance_to(Vector2(176, 448)) < 5, "Route arrival is clear of return trigger")
	await _advance(5)
	_check(current_scene == route, "Route arrival does not immediately retrigger")
	player.position = Vector2(234, 160)
	Input.action_press("move_right")
	await _advance(40)
	Input.action_release("move_right")
	_check(player.position.x <= 247.1, "Route obstacle blocks movement")
	player.position = Vector2(56, 320)
	Input.action_press("move_left")
	await _advance(40)
	Input.action_release("move_left")
	_check(player.position.x >= 40.9, "Route outer wall blocks leaving the map")
	player.position = Vector2(176, 448)
	await _advance(3)

	Input.action_press("move_left")
	for index in 100:
		await physics_frame
		if current_scene != route:
			break
	Input.action_release("move_left")
	await _advance(3)
	_check(current_scene != route and current_scene.name == "TestVillage", "Route exit returns to Village")
	player = current_scene.get_node("Player")
	_check(player.position.distance_to(Vector2(1104, 448)) < 5, "Village return spawn is clear of exit")
	var returned_village := current_scene
	await _advance(5)
	_check(current_scene == returned_village, "Village arrival does not immediately retrigger")

	_check(change_scene_to_file("res://scenes/world/test_village.tscn") == OK, "Village relaunch succeeds")
	await _advance(3)
	player = current_scene.get_node("Player")
	_check(player.position == Vector2(160, 448), "Relaunch resets initial spawn")
	print("PN-002 smoke test: ", "PASS (%d checks)" % checks if failures == 0 else "%d failure(s) in %d checks" % [failures, checks])
	quit(0 if failures == 0 else 1)
