extends RigidBody2D
@onready var Plinko = get_parent()

var multiplier


func set_multiplier(x):
	multiplier = x
	$Sprite2D/Label.text = "x" + str(multiplier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detection_body_entered(body: Node2D) -> void:
	# this is a really weird hack but it works, ok? dont judge me
	if (body.editor_description != "ball"):
		return
	
	body.freeze = true
	
	if (multiplier == 0):
		Plinko.money_before = Plinko.money
	Plinko.set_money(Plinko.get_money() * multiplier)
