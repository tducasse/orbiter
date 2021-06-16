extends KinematicBody2D

onready var Detector = $Detector


var speed = 15000
var velocity = Vector2.ZERO


func get_input():
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


func check_detected(other):
	Detector.enabled = true
	var dir = global_position.direction_to(other.global_position)
	Detector.cast_to = dir * global_position.distance_to(other.global_position)
	Detector.force_raycast_update()
	var collider = Detector.get_collider()
	Detector.enabled = false
	print(collider)
	if collider:
		if collider.name == "GuardArea":
			print("detected")
		


