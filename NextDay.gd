extends RigidBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ball_array = get_parent().ball_array
	var should_show = true
	
	if (get_parent().balls != 0): should_show = false
	
	for i in ball_array:
		if (i.stop_watch > 12 || i.editor_description != "ball" && should_show):
			should_show = true
		else:
			should_show = false
	
	if (should_show):
		visible = true
		$CollisionShape2D.disabled = false
	else:
		visible = false
		$CollisionShape2D.disabled = true
