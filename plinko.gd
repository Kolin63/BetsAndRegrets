extends Node2D

var DEBUG_MODE = false

@onready var Peg = $Peg
@onready var Bucket = $Bucket
@onready var Ball = $Ball
@onready var Bubble = $Bubble
@onready var DialogueManager = $DialogueManager
@onready var Man = $Man/Man
@onready var SFX = $SFX

var money = 5.32
var balls = 1
var day = 1
var soul = 4

var money_before = money

var times_zeroed = 0
var times_lose_sequential = 0
var soul_day_before = soul
var is_intro = 1

var ball_array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.set_bubble(Bubble)
	DialogueManager.dia(0)
	money = 5.32
	balls = 1
	set_soul(4)
	set_balls(day)
	generate(18)
	
	if (DEBUG_MODE):
		print("⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ DEBUG MODE ACTIVATED ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n\t\tDisable it on Plinko.gd line 3\n")
		$DayCount.text = "DEBUG MODE"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Spawn Ball
	if (Input.is_action_just_pressed("click") && balls > 0):
		var ball = Ball.duplicate()
		ball.position = get_viewport().get_mouse_position()
		if (!DEBUG_MODE):
			ball.position.y = 125
		ball.gravity_scale = 1
		add_child(ball)
		set_balls(balls - 1)
		ball_array.append(ball)
		$SFX.playsound(load("res://sfx/Drop Ball.wav"))
	
	
	# Ball Preview
	if (balls > 0):
		$BallPreview.visible = true
		$BallPreview.position = get_viewport().get_mouse_position()
		$BallPreview.position.y = 125
	else:
		$BallPreview.visible = false
	
	
	# Dialogue Debug
	if (Input.is_action_just_pressed("debug") && !DEBUG_MODE):
		DEBUG_MODE = true
		$Debug.visible = true


func _on_next_day_pressed() -> void:
	new_day()
	$SFX.playsound(load("res://sfx/Next Day.wav"))


func new_day():
	day += 1
	$DayCount.text = "Day " + str(day)
	if (money != 0):
		set_balls(day)
	for i in ball_array:
		remove_child(i)
	ball_array.clear()
	
	
	# Handle Dialogue
	if (money < money_before):
		times_lose_sequential += 1
	else:
		times_lose_sequential = 0
	
	if (money == 0):
		pass
	elif (soul == 4 && money_before > money && money > money_before * 5 && !Bubble.Dialogue.playing):
		# wins day, max soul, earnings between 1x and 5x
		DialogueManager.dia(2)
	elif (soul == 4 && money > money_before * 5 && !Bubble.Dialogue.playing):
		# wins day, max soul, earnings above 5x
		DialogueManager.dia(8)
	elif (soul_day_before == 2 && money > money_before):
		# win day, day after lose 2 soul
		DialogueManager.dia(16)
	elif (soul_day_before == 3 && money > money_before):
		# win day, day after lose 3 soul
		DialogueManager.dia(20)
	elif (money > money_before && money > 9000000):
		# win day, money > 9 mil (IM SO CLOSE!!! 🥵)
		DialogueManager.dia(18)
	elif (money > money_before && !Bubble.Dialogue.playing):
		# win, no other conditions
		DialogueManager.dia(11)
	
	if (money == 0):
		pass
	elif (soul == 4 && times_lose_sequential == 3):
		# max soul, 3 loss in row
		DialogueManager.dia(9)
	elif (soul_day_before == 2 && money < money_before):
		# day after lose 2 soul, lost round
		DialogueManager.dia(15)
	elif (soul_day_before == 3 && money < money_before):
		# day after lose 3 soul, lost round
		DialogueManager.dia(17)
	elif (money_before > 9000000 && money < 9000000):
		# lose, goes under 9 mil
		DialogueManager.dia(19)
	elif (money < money_before && !Bubble.Dialogue.playing):
		# loses, no other conditions
		DialogueManager.dia(10)
	
	if (times_zeroed == 1 && money == 0):
		DialogueManager.dia(3)
	if (times_zeroed == 2 && money == 0):
		DialogueManager.dia(4)
	if (times_zeroed == 3 && money == 0):
		DialogueManager.dia(5)
	if (times_zeroed == 4 && money == 0):
		DialogueManager.dia(7)
	
	if (day == 7 && money_before != 0 && !Bubble.Dialogue.playing):
		DialogueManager.dia(14)
	
	
	soul_day_before = soul


func get_money():
	return money


func set_money(x, mux = -1):
	money_before = money
	money = round_place(x, 2)
	$Money.text = "$" + str(money)
	if (money == 0 && mux != 0):
		set_money(0.01)
	if (money == 0):
		set_balls(0)
		
		# remove all non-used balls
		for i in ball_array:
			if (i.editor_description != "used ball"):
				remove_child(i)
				i.editor_description = "used ball"
		
		times_zeroed += 1
	
	# 10 million dollars win state
	if (money >= 10000000):
		DialogueManager.dia(6)


func set_balls(x):
	balls = x
	$BallsCount.text = "Balls: " + str(balls) + " / " + str(day)


func set_soul(x):
	soul_day_before = soul
	soul = x
	$Soul/Soul.frame = soul - 1
	$Soul/CollisionShape2D.shape.radius = 30 * soul
	if (soul <= 0):
		$Soul.visible = false


func remove_soul(timpani = false):
	if (timpani):
		$Bubble/Music.stream = load("res://sfx/Timpani.wav")
		$Bubble/Music.play()
		for i in range(0, 600):
			$Soul.scale += Vector2(0.001, 0.001)
			$Soul.rotation += 0.1
			await get_tree().create_timer(0.001).timeout
	
	if (soul == 1):
		$Bubble/Music.stream = load("res://sfx/Soul Zero.wav")
	else:
		$Bubble/Music.stream = load("res://sfx/Soul Loss.wav")
	
	$Bubble/Music.play()
	$Soul.scale = Vector2(1, 1)
	$Soul.rotation = 0
	set_soul(soul - 1)
	set_money(money_before / 10)
	set_balls(day)
	await get_tree().create_timer(5).timeout


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


# Example: 
# round_place(5.3678, 2)
# returns 5.37
#
# round_place(5.3648, 2)
# returns 5.36
func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))


# Generate the pegs
func generate(base_pegs):
	# Declare some variables 
	var viewport_size = get_viewport().get_visible_rect().size
	const bottom_padding = 100
	const side_padding = 20
	
	# Wow that's a lot of variables!
	const peg_size = 18*1.5
	const peg_padding = peg_size
	
	# Oh my gosh there are more variables!
	var total_pegs = get_total_pegs(base_pegs)
	var rows = get_rows(base_pegs)
	var middle = get_middle_of_viewport_x(viewport_size.x, peg_size)
	
	# Oh shoot! I miss the simplicity of variable declarations! 
	# There's a nested for loop NOOOOO
	
	# Iterate for each row
	for i in range(1, rows):
		# There is one less peg each row
		var pegs_in_row = base_pegs - i + 1
		
		# Iterate for each peg
		for j in range(1, pegs_in_row):
			var peg = Peg.duplicate()
			# Do some weird stuff to make it in the right spot
			#
			# I wrote this a while ago and I don't even want to try and
			# figure out how it works
			peg.position.x = (get_peg_position_x(pegs_in_row, j, peg_size, peg_padding, middle))
			peg.position.y = (viewport_size.y - bottom_padding) - ((peg_size + peg_padding) * i)
			add_child(peg)
			
			# If it's the bottom row, we need some BUCKETS!
			if (i == 1 && j < pegs_in_row - 1):
				var bucket = Bucket.duplicate()
				# Move it below and center it
				bucket.position = peg.position
				bucket.position.x += peg_padding
				bucket.position.y += peg_padding * 3
				# Find distance from center
				var dist_from_center = abs(pegs_in_row / 2 - j)
				# We do this so that it is symmetrical 
				if (j <= 8):
					dist_from_center -= 1
				# multiplier = (0.25 * dist_from_center^2) / 2, rounded to 100th
				# https://www.desmos.com/calculator/hvyub2amug
				bucket.set_multiplier(round_place((0.25 * pow(dist_from_center, 2) / 2), 2))
				# Add Bucket
				add_child(bucket)


func _on_music_finished() -> void:
	$Bubble/Music.play()
