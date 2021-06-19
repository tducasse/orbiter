extends Control


func _ready():
	get_tree().paused = false
	pause_mode = PAUSE_MODE_PROCESS


func _on_Start_pressed():
	var _c = get_tree().change_scene("res://Game.tscn")
