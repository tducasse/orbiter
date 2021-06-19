extends StaticBody2D


var init_pos = null
onready var Coll = $Coll


func _ready():
	init_pos = position


func reset():
	position = init_pos
	visible = true
	Coll.disabled = false


func pick():
	Coll.set_deferred("disabled", true)
	visible = false
