extends AcceptDialog

signal reset()
signal back()


func _ready():
	var back_button = add_button("Back to menu", true, "back")
	var ok_button = get_ok()
	ok_button.text = "Try again"
	var font = load("res://Spacetime_small.tres")
	ok_button.add_font_override("font", font)
	back_button.add_font_override("font", font)
	get_close_button().visible = false
	

func _process(_delta):
	if not visible:
		return
	if Input.is_action_pressed('ui_accept'):
		reset()
	if Input.is_action_pressed('ui_cancel'):
		back()


func reset():
	emit_signal("reset")


func back():
	emit_signal("back")
