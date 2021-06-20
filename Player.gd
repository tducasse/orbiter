extends KinematicBody2D

onready var Detector = $Detector
onready var PlayerSprite = $Sprite
onready var GameOver = $HUD/GameOver
onready var Parts = $HUD/Parts
onready var Time = $HUD/Time
onready var PickupSound = $PickupSound
onready var DetectedSound = $DetectedSound


var speed = 15000
var velocity = Vector2.ZERO
var time = 0.0

signal restart()
signal picked(body)


var init_position = null

func _ready():
	init_position = position
	pause_mode = PAUSE_MODE_PROCESS
	
	
func _process(delta):
	if not get_tree().paused:
		time += delta
		update_time()


func update_time():
	var m = time/60
	var s = fmod(time, 60)
	var ms = fmod(time, 1) * 100
	var time_string := "%02d:%02d:%02d" % [m, s, ms]
	Global.time = time_string
	Time.text = str(time_string)


func get_input():
	if get_tree().paused:
		return
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized()
	velocity = velocity * speed
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * delta)
	if velocity.length() > 0:
		PlayerSprite.rotation = velocity.angle() + 1.5


func check_detected(other):
	Detector.enabled = true
	var dir = global_position.direction_to(other.global_position)
	Detector.cast_to = dir * global_position.distance_to(other.global_position)
	Detector.force_raycast_update()
	var collider = Detector.get_collider()
	Detector.enabled = false
	if collider:
		if collider.name == "GuardArea":
			GameOver.popup_centered()
			DetectedSound.play()
			get_tree().paused = true
		

func reset():
	time = 0.0
	GameOver.hide()
	position = init_position


func _on_GameOver_confirmed():
	emit_signal("restart")


func _on_Pickup_body_entered(body):
	if body.name in ["RightWing", "LeftWing", "Engine", "Top", "Window"]:
		PickupSound.play()
		emit_signal("picked", body)


func update_parts(picked, total):
	Parts.text = "Parts: " + str(picked) + '/' + str(total)


func back():
	Music.stop()
	GameOver.hide()
	var _c = get_tree().change_scene("res://Menu.tscn")


func _on_GameOver_custom_action(action):
	if action == "back":
		back()


func _on_GameOver_back():
	back()


func _on_GameOver_reset():
	emit_signal("restart")
