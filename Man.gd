extends RigidBody2D

var balls_inside_checker = 0

var default_pos = Vector2(98, 365)
var slide_pos = Vector2(-300, 365)


func _ready():
	$HeadDropTimer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CollisionPolygon2D.disabled = !visible
	
	if (balls_inside_checker):
		$HeadDropTimer.start()
	
	slide_animation()


func slide_animation():
	if ($HeadDropTimer.time_left > 0):
		if (position.x >= slide_pos.x):
			position.x -= 10
		if ($Man.animation == "think"):
			$Man.animation = "open"
	else:
		if (position.x <= default_pos.x):
			position.x += 10
		if ($Man.animation == "open"):
			$Man.animation = "think"


func _on_head_drop_check_body_entered(body):
	if (body.editor_description == "ball"):
		balls_inside_checker += 1


func _on_head_drop_check_body_exited(body):
	if (body.editor_description == "ball"):
		balls_inside_checker -= 1
