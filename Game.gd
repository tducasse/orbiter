extends Node2D

onready var Player = $Player
onready var Guards = $Guards
onready var Parts = $Parts

var total_parts = 0
var parts_picked = 0


func _ready():
	Guards.visible = true
	MenuMusic.stop()
	total_parts = Parts.get_child_count()
	pause_mode = Node.PAUSE_MODE_PROCESS
	for guard_path in Guards.get_children():
		for guard in guard_path.get_children():
			guard.pause_mode = Node.PAUSE_MODE_STOP
	Music.play()
	Player.update_parts(parts_picked, total_parts)


func _on_Player_restart():
	Player.reset()
	parts_picked = 0
	Player.update_parts(parts_picked, total_parts)
	for guard_path in Guards.get_children():
		for guard in guard_path.get_children():
			guard.reset()
	for part in Parts.get_children():
		part.reset()
	get_tree().paused = false


func _on_Player_picked(part):
	part.pick()
	update_parts()
	
	
func end_game():
	Music.stop()
	var _c = get_tree().change_scene("res://Win.tscn")
	
	
func update_parts():
	parts_picked +=1
	Player.update_parts(parts_picked, total_parts)
	if parts_picked == total_parts:
		end_game()
