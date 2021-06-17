extends PathFollow2D

onready var Detection = $Detection

var speed = 100
var init_offset = null


func _ready():
	init_offset = offset


func _process(delta):
	offset += speed * delta


func _physics_process(_delta):
	for body in Detection.get_overlapping_bodies():
		if body.has_method("check_detected"):
			body.check_detected(self)


func reset():
	offset = init_offset
