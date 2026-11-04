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


func _key(physical_code: int, pressed: bool, echo: bool = false) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = physical_code
	event.pressed = pressed
	event.echo = echo
	Input.parse_input_event(event)


func _run() -> void:
	_check(change_scene_to_file("res://scenes/world/test_village.tscn") == OK, "Village opens")
	await _advance(4)
	var village := current_scene
	var player: CharacterBody2D = village.get_node("Player")
	var npc: StaticBody2D = village.get_node("GuideNPC")
	var ui: DialogueUI = npc.get_node("DialogueUI")
	_check(npc.position == Vector2(480, 448), "NPC sits on an accessible path")
	_check(not npc.get_node("Prompt").visible and not ui.visible, "No prompt or panel at a distance")
	_check(InputMap.has_action("interact") and InputMap.action_get_events("interact").size() == 2, "E and Enter are mapped")
	_key(KEY_E, true)
	await _advance(2)
	_key(KEY_E, false)
	_check(not ui.visible, "Distant E does not open dialogue")

	player.position = Vector2(435, 448)
	await _advance(4)
	_check(npc.can_interact() and npc.get_node("Prompt").visible, "Prompt appears within 48 pixels")

	# A temporary blocker tests the raycast without changing the authored map.
	var test_wall := StaticBody2D.new()
	test_wall.collision_layer = 1
	test_wall.collision_mask = 0
	test_wall.position = Vector2(457, 448)
	var wall_collider := CollisionShape2D.new()
	var wall_shape := RectangleShape2D.new()
	wall_shape.size = Vector2(4, 32)
	wall_collider.shape = wall_shape
	test_wall.add_child(wall_collider)
	village.add_child(test_wall)
	await _advance(3)
	_check(not npc.can_interact() and not npc.get_node("Prompt").visible, "Intervening blocker suppresses interaction")
	test_wall.queue_free()
	await _advance(3)
	_check(npc.can_interact(), "Interaction returns after blocker removal")

	_key(KEY_E, true)
	await _advance(2)
	_check(ui.visible and ui.line_index == 0, "One E press opens on the first line")
	_check(ui.speaker_label.text == "Village Guide" and ui.body_label.text == "Welcome to the test village.", "Speaker and first line come from dialogue data")
	_check(player.movement_locked and not npc.get_node("Prompt").visible, "Dialogue locks movement and hides prompt")
	_key(KEY_E, true, true)
	await _advance(2)
	_check(ui.line_index == 0, "Held-key echo does not skip a line")
	_key(KEY_E, false)
	var locked_position := player.position
	Input.action_press("move_right")
	await _advance(8)
	Input.action_release("move_right")
	_check(player.position == locked_position and player.velocity == Vector2.ZERO, "Movement stays locked during dialogue")

	_key(KEY_ENTER, true)
	await _advance(2)
	_check(ui.visible and ui.line_index == 1, "Enter advances exactly one line")
	_check(ui.body_label.text == "The cyan path to the east leads to the test route.", "Second line is displayed")
	_key(KEY_ENTER, false)
	_key(KEY_E, true)
	await _advance(2)
	_check(ui.visible and ui.line_index == 2, "Next E press shows third line")
	_check(ui.body_label.text == "You can return here through the route's western exit.", "Third line is displayed")
	_key(KEY_E, false)
	_key(KEY_E, true)
	await _advance(2)
	_key(KEY_E, false)
	_check(not ui.visible and not player.movement_locked, "Final interaction closes and unlocks movement")

	_key(KEY_E, true)
	await _advance(2)
	_key(KEY_E, false)
	_check(ui.visible and ui.line_index == 0, "Conversation can be reopened from line one")
	var cancel := InputEventKey.new()
	cancel.keycode = KEY_ESCAPE
	cancel.pressed = true
	Input.parse_input_event(cancel)
	await _advance(2)
	_check(not ui.visible and not player.movement_locked, "Escape cancels and unlocks movement")
	cancel.pressed = false
	Input.parse_input_event(cancel)

	_key(KEY_E, true)
	await _advance(2)
	_key(KEY_E, false)
	_check(ui.visible, "Dialogue reopens before proximity-change check")
	player.position = Vector2(160, 448)
	await _advance(4)
	_check(ui.visible and player.movement_locked and not npc.get_node("Prompt").visible, "Leaving range during dialogue keeps panel and lock consistent")
	cancel.pressed = true
	Input.parse_input_event(cancel)
	await _advance(2)
	cancel.pressed = false
	Input.parse_input_event(cancel)
	_check(not ui.visible and not player.movement_locked, "Cancel unlocks player after proximity reference is lost")
	_check(not npc.get_node("Prompt").visible and not npc.can_interact(), "Leaving range hides prompt")
	player.position = Vector2(440, 448)
	Input.action_press("move_right")
	await _advance(40)
	Input.action_release("move_right")
	_check(player.position.x <= 459.1, "NPC collider stops the player")

	player.position = Vector2(1150, 448)
	Input.action_press("move_right")
	for index in 100:
		await physics_frame
		if current_scene != village:
			break
	Input.action_release("move_right")
	await _advance(3)
	_check(current_scene != village and current_scene.name == "TestRoute", "Village exit still loads Route")
	var route := current_scene
	_check(route.get_node_or_null("GuideNPC") == null, "Village NPC and panel do not leak into Route")
	player = route.get_node("Player")
	Input.action_press("move_left")
	for index in 100:
		await physics_frame
		if current_scene != route:
			break
	Input.action_release("move_left")
	await _advance(3)
	_check(current_scene != route and current_scene.name == "TestVillage", "Route exit still returns to Village")
	player = current_scene.get_node("Player")
	npc = current_scene.get_node("GuideNPC")
	ui = npc.get_node("DialogueUI")
	player.position = Vector2(435, 448)
	await _advance(4)
	_key(KEY_E, true)
	await _advance(2)
	_key(KEY_E, false)
	_check(ui.visible and ui.line_index == 0, "Returned NPC can interact without stale references")
	_check(current_scene.get_node("GuideNPC/DialogueUI/Panel").get_global_rect().end.y <= 540, "Dialogue panel fits 960x540 viewport")
	_check(change_scene_to_file("res://scenes/world/test_route.tscn") == OK, "Active dialogue permits clean world replacement")
	await _advance(3)
	_check(current_scene.name == "TestRoute" and current_scene.get_node_or_null("GuideNPC") == null, "Dialogue panel is freed with Village")
	_check(not current_scene.get_node("Player").movement_locked, "New world player starts unlocked")

	print("PN-003 smoke test: ", "PASS (%d checks)" % checks if failures == 0 else "%d failure(s) in %d checks" % [failures, checks])
	quit(0 if failures == 0 else 1)
