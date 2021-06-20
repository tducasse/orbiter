extends Control


onready var CreditsDialog = $CreditsDialog


func _ready():
	get_tree().paused = false
	pause_mode = PAUSE_MODE_PROCESS
	if not MenuMusic.playing:
		MenuMusic.play()

func _process(_delta):
	if Input.is_action_pressed('ui_accept'):
		start()


func start():
	var _c = get_tree().change_scene("res://Game.tscn")
	
func _on_Start_pressed():
	start()


func _on_Credits_pressed():
	CreditsDialog.popup_centered()
