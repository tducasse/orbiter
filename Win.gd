extends Control

onready var Time = $CenterContainer/VBoxContainer/MarginContainer2/Time

func _ready():
	if not MenuMusic.playing:
		MenuMusic.play()
	Time.text = Global.time

func _process(_delta):
	if Input.is_action_pressed('ui_accept'):
		back()

func back():
	var _c = get_tree().change_scene("res://Menu.tscn")

func _on_Back_pressed():
	back()
