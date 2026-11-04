extends Node2D

const TILE := 32
const MAP_WIDTH := 40
const MAP_HEIGHT := 28
const MAP_SIZE := Vector2(MAP_WIDTH * TILE, MAP_HEIGHT * TILE)
const PLAYER_SCENE := preload("res://scenes/player.tscn")
const NPC_SCENE := preload("res://scenes/npc.tscn")
const ARRIVAL_META := &"pn002_arrival_from"

@export_enum("village", "route") var zone: String = "village"

var player: CharacterBody2D
var blockers: Array[Rect2] = []
var exit_rect: Rect2
var _transitioning := false


func _ready() -> void:
	_build_layout()
	_build_collisions()
	_build_exit()
	_spawn_player()
	_build_npc()
	_build_labels()
	queue_redraw()


func _build_layout() -> void:
	# Every rectangle is aligned to the 32 px design grid. The four outer
	# rectangles leave no gap through which the player can leave the map.
	blockers = [
		Rect2(0, 0, MAP_SIZE.x, TILE),
		Rect2(0, MAP_SIZE.y - TILE, MAP_SIZE.x, TILE),
		Rect2(0, TILE, TILE, MAP_SIZE.y - 2 * TILE),
		Rect2(MAP_SIZE.x - TILE, TILE, TILE, MAP_SIZE.y - 2 * TILE),
	]
	if zone == "village":
		blockers.append_array([
			Rect2(6 * TILE, 3 * TILE, 6 * TILE, 4 * TILE),
			Rect2(22 * TILE, 3 * TILE, 7 * TILE, 4 * TILE),
			Rect2(5 * TILE, 19 * TILE, 8 * TILE, 2 * TILE),
			Rect2(21 * TILE, 19 * TILE, 8 * TILE, 3 * TILE),
			Rect2(15 * TILE, 8 * TILE, 2 * TILE, 2 * TILE),
			Rect2(32 * TILE, 8 * TILE, 2 * TILE, 2 * TILE),
		])
		exit_rect = Rect2(37 * TILE, 12 * TILE, TILE, 4 * TILE)
	else:
		blockers.append_array([
			Rect2(8 * TILE, 3 * TILE, 5 * TILE, 6 * TILE),
			Rect2(19 * TILE, 4 * TILE, 7 * TILE, 4 * TILE),
			Rect2(30 * TILE, 2 * TILE, 4 * TILE, 7 * TILE),
			Rect2(7 * TILE, 19 * TILE, 5 * TILE, 4 * TILE),
			Rect2(18 * TILE, 19 * TILE, 8 * TILE, 5 * TILE),
			Rect2(31 * TILE, 18 * TILE, 4 * TILE, 5 * TILE),
		])
		exit_rect = Rect2(2 * TILE, 12 * TILE, TILE, 4 * TILE)


func _build_collisions() -> void:
	for index in blockers.size():
		var rect := blockers[index]
		var wall := StaticBody2D.new()
		wall.name = "Blocker_%d" % index
		wall.collision_layer = 1
		wall.collision_mask = 0
		wall.position = rect.get_center()
		var collider := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		shape.size = rect.size
		collider.shape = shape
		wall.add_child(collider)
		add_child(wall)


func _build_exit() -> void:
	var area := Area2D.new()
	area.name = "ExitToRoute" if zone == "village" else "ExitToVillage"
	area.collision_layer = 0
	area.collision_mask = 2
	area.position = exit_rect.get_center()
	var collider := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = exit_rect.size
	collider.shape = shape
	area.add_child(collider)
	add_child(area)
	area.body_entered.connect(_on_exit_entered)


func _spawn_player() -> void:
	player = PLAYER_SCENE.instantiate()
	player.name = "Player"
	var arrived_from := ""
	if get_tree().has_meta(ARRIVAL_META):
		arrived_from = String(get_tree().get_meta(ARRIVAL_META))
		get_tree().remove_meta(ARRIVAL_META)
	# Arrival points are outside the exit areas, so the new scene cannot
	# immediately transition back before the player presses a direction.
	if zone == "village":
		player.position = Vector2(1104, 448) if arrived_from == "route" else Vector2(160, 448)
	else:
		player.position = Vector2(176, 448) if arrived_from == "village" else Vector2(1104, 448)
	add_child(player)


func _build_labels() -> void:
	var hud := CanvasLayer.new()
	hud.name = "HUD"
	add_child(hud)
	var title := Label.new()
	title.position = Vector2(16, 12)
	title.add_theme_font_size_override("font_size", 22)
	title.text = "TEST VILLAGE" if zone == "village" else "TEST ROUTE"
	hud.add_child(title)
	var help := Label.new()
	help.position = Vector2(16, 44)
	help.add_theme_font_size_override("font_size", 14)
	help.text = "WASD / arrows: move  |  Cyan exit EAST >" if zone == "village" else "WASD / arrows: move  |  < Cyan exit WEST"
	hud.add_child(help)
	var marker := Label.new()
	marker.name = "ExitMarker"
	marker.position = Vector2(exit_rect.position.x - (98 if zone == "village" else -36), exit_rect.position.y - 26)
	marker.add_theme_font_size_override("font_size", 15)
	marker.text = "TO ROUTE >" if zone == "village" else "< TO VILLAGE"
	add_child(marker)


func _build_npc() -> void:
	if zone != "village":
		return
	var npc := NPC_SCENE.instantiate()
	npc.name = "GuideNPC"
	npc.position = Vector2(480, 448)
	add_child(npc)


func _on_exit_entered(body: Node2D) -> void:
	if body != player or _transitioning:
		return
	_transitioning = true
	get_tree().set_meta(ARRIVAL_META, zone)
	var destination := "res://scenes/world/test_route.tscn" if zone == "village" else "res://scenes/world/test_village.tscn"
	get_tree().call_deferred("change_scene_to_file", destination)


func _draw() -> void:
	var base := Color(0.25, 0.40, 0.32) if zone == "village" else Color(0.43, 0.38, 0.27)
	var variation := Color(0.28, 0.43, 0.34) if zone == "village" else Color(0.46, 0.41, 0.29)
	var path_color := Color(0.53, 0.48, 0.34) if zone == "village" else Color(0.56, 0.48, 0.32)
	for row in MAP_HEIGHT:
		for column in MAP_WIDTH:
			var tile_rect := Rect2(column * TILE, row * TILE, TILE, TILE)
			var color := base if (column + row) % 2 == 0 else variation
			if row >= 12 and row <= 15:
				color = path_color
			draw_rect(tile_rect, color)
	var blocker_color := Color(0.23, 0.29, 0.38) if zone == "village" else Color(0.27, 0.32, 0.34)
	for rect in blockers:
		draw_rect(rect, blocker_color)
		draw_rect(rect.grow(-3), blocker_color.lightened(0.15), false, 2.0)
	draw_rect(exit_rect, Color(0.15, 0.78, 0.83, 1.0))
	draw_rect(exit_rect.grow(-4), Color(0.72, 0.96, 0.97, 1.0), false, 2.0)
