extends RigidBody2D
@onready var Plinko = get_parent()

var multiplier = 1
var modifier = 0
var total


func set_multiplier(mux, mod = modifier): 
	multiplier = mux
	modifier = mod
	total = mux + mod
	$Sprite2D/Label.text = "x" + str(total)


func set_modifier(mod):
	modifier = mod
	set_multiplier(multiplier, modifier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (multiplier == 0 && get_parent().is_intro):
		set_modifier(0.1)
	else:
		set_modifier(0)


func _on_detection_body_entered(body: Node2D) -> void:
	# this is a really weird hack but it works, ok? dont judge me
	if (body.editor_description != "ball"):
		return
	
	body.editor_description = "used ball"
	
	if (multiplier == 0):
		Plinko.money_before = Plinko.money
	Plinko.set_money(Plinko.get_money() * multiplier, total)
