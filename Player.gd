extends KinematicBody2D

onready var Detector = $Detector
onready var PlayerSprite = $Sprite
onready var GameOver = $HUD/GameOver
onready var Parts = $HUD/Parts


var speed = 15000
var velocity = Vector2.ZERO

signal restart()
signal picked(body)


var init_position = null

func _ready():
	init_position = position
	pause_mode = PAUSE_MODE_PROCESS


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
			get_tree().paused = true
		

func reset():
	position = init_position


func _on_GameOver_confirmed():
	emit_signal("restart")


func _on_Pickup_body_entered(body):
	if body.name == "Part":
		emit_signal("picked", body)


func update_parts(picked, total):
	Parts.text = "Parts: " + str(picked) + '/' + str(total)
