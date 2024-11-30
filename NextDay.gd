extends TextureButton


# Button only shows when you have 0 balls
func _process(delta):
	visible = !get_parent().balls
