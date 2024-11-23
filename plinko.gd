extends Node2D
@onready var Peg = $Peg
@onready var Bucket = $Bucket
@onready var Ball = $Ball

var money
var balls
var day


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 5.32
	balls = 1
	generate(18)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Spawn Ball
	if (Input.is_action_pressed("click") && balls > 0):
		var ball = Ball.duplicate()
		ball.position = get_viewport().get_mouse_position()
		ball.position.y = 25
		ball.gravity_scale = 1
		add_child(ball)
		set_balls(balls - 1)


	# Ball Preview
	if (balls > 0):
		$BallPreview.visible = true
		$BallPreview.position = get_viewport().get_mouse_position()
		$BallPreview.position.y = 25
	else:
		$BallPreview.visible = false


func new_day():
	day += 1
	set_balls(day)


func get_money():
	return money


func set_money(x):
	money = x
	$Money.text = "$" + str(money)


func set_balls(x):
	balls = x
	$BallsCount.text = "Balls: " + str(balls)


# Calculates total amount of pegs
func get_total_pegs(base_pegs):
	var total = 0
	# For each row, there is one less peg
	for i in range(base_pegs, 0, -1):
		total += i
	# Top row is only 3 pegs, so we subtract the
	# row with 2 pegs and the row with 1 peg
	total -= 3
	
	return total


# Gets number of rows
func get_rows(base_pegs):
	var rows = 0
	var pegs_in_row = base_pegs
	while (pegs_in_row >= 3):
		rows += 1
		pegs_in_row -= 1
	return rows

# Calculates middle of viewport, offset by half of sprite
# size. So that the sprite is centered. 
func get_middle_of_viewport_x(size_x, sprite_size = 0):
	# This finds the middle pixel
	var middle = size_x / 2
	# Now offset it by half the sprite size
	# This way, if we set the sprite's position to
	# middle, then the sprite will be centered
	middle -= (sprite_size / 2)
	
	return middle


# Gets the x position of a given peg 
func get_peg_position_x(pegs_in_row, peg_index, peg_size, peg_padding, middle):
	var position = middle
	
	# Offset if pegs in row is even
	if (pegs_in_row % 2 == 0):
		position += peg_size
	
	# First, set position to left most peg
	for i in range(floor(pegs_in_row / 2), 0, -1):
		position -= (peg_size + peg_padding)
	
	# Now, set the position to the actual one
	for i in range(1, peg_index):
		position += peg_size + peg_padding
	
	return position 


# Generate the pegs
func generate(base_pegs):
	var viewport_size = get_viewport().get_visible_rect().size
	const bottom_padding = 40
	const side_padding = 20
	
	const peg_size = 18
	const peg_padding = peg_size
	
	var total_pegs = get_total_pegs(base_pegs)
	var rows = get_rows(base_pegs)
	var middle = get_middle_of_viewport_x(viewport_size.x, peg_size)
	
	for i in range(1, rows):
		var pegs_in_row = base_pegs - i + 1
		
		for j in range(1, pegs_in_row):
			var peg = Peg.duplicate()
			peg.position.x = (get_peg_position_x(pegs_in_row, j, peg_size, peg_padding, middle))
			peg.position.y = (viewport_size.y - bottom_padding) - ((peg_size + peg_padding) * i)
			add_child(peg)
			if (i == 1):
				var bucket = Bucket.duplicate()
				bucket.position = peg.position
				bucket.position.x += peg_padding
				bucket.position.y += peg_padding * 3
				add_child(bucket)
				var dist_from_center = abs(pegs_in_row / 2 - j)
				bucket.set_multiplier(0.25 * dist_from_center * dist_from_center / 2)
				bucket.set_multiplier((0.25 * dist_from_center * dist_from_center) / 2)
