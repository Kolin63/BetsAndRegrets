extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate(18)


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


func generate(base_pegs):
	var viewport_size = get_viewport().get_visible_rect().size
	const bottom_padding = 80
	const side_padding = 20
	var total_pegs = get_total_pegs(base_pegs)
	const peg_size = 10
	const peg_padding = peg_size
	var rows = get_rows(base_pegs)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
