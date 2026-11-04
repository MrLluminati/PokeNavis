extends SceneTree


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	change_scene_to_file("res://scenes/world/test_village.tscn")
	for index in 3:
		await physics_frame
	var player: CharacterBody2D = current_scene.get_node("Player")
	player.position = Vector2(435, 448)
	for index in 8:
		await physics_frame
	var interact := InputEventKey.new()
	interact.physical_keycode = KEY_E
	interact.pressed = true
	Input.parse_input_event(interact)
	await physics_frame
	interact.pressed = false
	Input.parse_input_event(interact)
