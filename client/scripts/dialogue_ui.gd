extends CanvasLayer
class_name DialogueUI

signal closed

var speaker := ""
var lines: Array[String] = []
var line_index := 0

@onready var speaker_label: Label = $Panel/Margin/Stack/Speaker
@onready var body_label: Label = $Panel/Margin/Stack/Body
@onready var hint_label: Label = $Panel/Margin/Stack/Hint


func open_dialogue(new_speaker: String, new_lines: Array[String]) -> void:
	if new_lines.is_empty():
		return
	speaker = new_speaker
	lines = new_lines.duplicate()
	line_index = 0
	visible = true
	_show_line()


func advance() -> void:
	if not visible:
		return
	line_index += 1
	if line_index >= lines.size():
		close_dialogue()
	else:
		_show_line()


func close_dialogue() -> void:
	if not visible:
		return
	visible = false
	closed.emit()


func _show_line() -> void:
	speaker_label.text = speaker
	body_label.text = lines[line_index]
	hint_label.text = "E / Enter: close  |  Esc: cancel" if line_index == lines.size() - 1 else "E / Enter: next  |  Esc: cancel"
