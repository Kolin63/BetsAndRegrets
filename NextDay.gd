extends RigidBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().balls == 0):
		visible = true
		$CollisionShape2D.disabled = false
	else:
		visible = false
		$CollisionShape2D.disabled = true
