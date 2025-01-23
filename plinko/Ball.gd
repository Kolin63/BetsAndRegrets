extends RigidBody2D

var stop_watch = 0
var do_stop_watch = 1

var previous_position 
var current_position 


# Called when the node enters the scene tree for the first time.
func _ready():
	if (position.y < 0):
		do_stop_watch = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	stop_watch += delta * do_stop_watch
	
	current_position = previous_position
	previous_position = position
	
	if (current_position == null || position.y < 0 || editor_description == "used ball" || stop_watch > 12):
		pass
	elif (current_position == previous_position):
		editor_description = "still ball"
	elif (stop_watch > 12):
		editor_description = "still ball"
	elif (position.y > get_viewport().get_visible_rect().size.y):
		editor_description = "still ball"
	elif (sleeping):
		editor_description = "still ball"
	elif (editor_description == "still ball" && current_position != previous_position):
		editor_description = "ball"
	
	
	bounce_detect()
	
	
	if (get_parent().DEBUG_MODE):
		if (editor_description == "ball"):
			modulate = Color(1, 1, 1)
		else:
			modulate = Color(1, 0, 0)


var previous_linear_velocity = null

func bounce_detect():
	if (previous_linear_velocity != null):
		if (abs(linear_velocity[0] - previous_linear_velocity[0]) > 100 
		or abs(linear_velocity[1] - previous_linear_velocity[1]) > 100
		and position.y < 1000):
			$AudioStreamPlayer2D.pitch_scale = randf_range(0.75, 1.25)
			$AudioStreamPlayer2D.play()
	
	previous_linear_velocity = linear_velocity
