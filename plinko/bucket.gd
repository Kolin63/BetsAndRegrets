extends RigidBody2D
@onready var Plinko = get_parent()

var multiplier = 1
var modifier = 0
var total

var max_mux = 1


func set_multiplier(mux, mod = modifier): 
	multiplier = mux
	modifier = mod
	total = mux + mod
	$Label.text = "x" + str(total)
	
	if (total > max_mux): 
		max_mux = total
	
	var ratio = 1 / max_mux 
	$Sprite2D.modulate = Color(1, 1 - ratio * (total/2) * (total/2), 0)


func set_modifier(mod):
	modifier = mod
	set_multiplier(multiplier, modifier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (multiplier == 0 && get_parent().is_intro):
		set_modifier(0.1)
	elif (multiplier == 0):
		set_modifier(0)


func _on_detection_body_entered(body: Node2D) -> void:
	# this is a really weird hack but it works, ok? dont judge me
	if (body.editor_description != "ball"):
		return
	
	body.editor_description = "used ball"
	
	if (multiplier == 0):
		Plinko.money_before = Plinko.money
		get_parent().SFX.playsound(load("res://sfx/Money Zero.wav"))
	Plinko.set_money(Plinko.get_money() * multiplier, total)
	
	if (multiplier <= 1 && multiplier > 0):
		get_parent().SFX.playsound(load("res://sfx/Money Loss.wav"))
	elif (multiplier > 1):
		get_parent().SFX.playsound(load("res://sfx/Money Gain.wav"))
