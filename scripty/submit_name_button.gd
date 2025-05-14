extends Node

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	var text = $LineEdit.text
	print("Zadaný text:", text)
