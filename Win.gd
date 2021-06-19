extends Control

func _ready():
	if not MenuMusic.playing:
		MenuMusic.play()

func _on_Back_pressed():
	var _c = get_tree().change_scene("res://Menu.tscn")
