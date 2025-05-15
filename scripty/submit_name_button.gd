extends Node

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	var text = $LineEdit.text
	get_tree().change_scene_to_file("res://Level1.tscn")
	print("Zadaný text:", text)
