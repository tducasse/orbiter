extends Node2D

onready var Player = $Player
onready var Guard = $GuardPath/Guard
onready var Guard2 = $GuardPath2/Guard
onready var GameOver = $GameOver


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	GameOver.pause_mode = Node.PAUSE_MODE_PROCESS
	Guard.pause_mode = Node.PAUSE_MODE_STOP
	Guard2.pause_mode = Node.PAUSE_MODE_STOP
	Player.pause_mode = Node.PAUSE_MODE_STOP


func _on_Player_detected():
	GameOver.popup_centered()
	get_tree().paused = true


func _on_GameOver_confirmed():
	get_tree().paused = false
	Player.reset()
	Guard.reset()
	Guard2.reset()
