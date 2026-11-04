extends Control

# PN-001: Minimal startup smoke-test script. No gameplay is implemented.
@onready var status_label: Label = $Center/Stack/Status


func _ready() -> void:
	status_label.text = "PN-001 | Godot 4.7.2 + GDScript"
	print("PokeNavis PN-001: startup scene ready")
