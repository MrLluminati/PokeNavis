extends StaticBody2D

const INTERACTION_RADIUS := 48.0

@export_file("*.json") var dialogue_path := "res://dialogue/test_villager.json"

var nearby_player: CharacterBody2D
var dialogue_player: CharacterBody2D
var dialogue_data: Dictionary = {}

@onready var range_area: Area2D = $InteractionRange
@onready var prompt: Label = $Prompt
@onready var dialogue_ui: DialogueUI = $DialogueUI


func _ready() -> void:
	dialogue_data = JSON.parse_string(FileAccess.get_file_as_string(dialogue_path))
	range_area.body_entered.connect(_on_body_entered)
	range_area.body_exited.connect(_on_body_exited)
	dialogue_ui.closed.connect(_on_dialogue_closed)
	prompt.visible = false


func _process(_delta: float) -> void:
	prompt.visible = not dialogue_ui.visible and can_interact()


func can_interact() -> bool:
	if not is_instance_valid(nearby_player):
		return false
	if global_position.distance_to(nearby_player.global_position) > INTERACTION_RADIUS:
		return false
	# The ray checks layer 1 blockers. Exclude this NPC's own collider.
	var query := PhysicsRayQueryParameters2D.create(global_position, nearby_player.global_position, 1, [get_rid()])
	return get_world_2d().direct_space_state.intersect_ray(query).is_empty()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if dialogue_ui.visible:
		if event.is_action_pressed("ui_cancel"):
			dialogue_ui.close_dialogue()
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("interact"):
			dialogue_ui.advance()
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed("interact") and can_interact():
		_open_dialogue()
		get_viewport().set_input_as_handled()


func _open_dialogue() -> void:
	var raw_lines: Array = dialogue_data.get("lines", [])
	var lines: Array[String] = []
	for line in raw_lines:
		lines.append(String(line))
	if lines.is_empty():
		return
	dialogue_player = nearby_player
	dialogue_player.movement_locked = true
	dialogue_player.velocity = Vector2.ZERO
	dialogue_ui.open_dialogue(String(dialogue_data.get("speaker", "")), lines)
	prompt.visible = false


func _on_dialogue_closed() -> void:
	if is_instance_valid(dialogue_player):
		dialogue_player.movement_locked = false
	dialogue_player = null


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		nearby_player = body


func _on_body_exited(body: Node2D) -> void:
	if body == nearby_player:
		nearby_player = null
		prompt.visible = false


func _exit_tree() -> void:
	if is_instance_valid(dialogue_player):
		dialogue_player.movement_locked = false
