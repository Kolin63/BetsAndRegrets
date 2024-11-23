extends RigidBody2D
@onready var Plinko = get_parent()

var multiplier


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func set_multiplier(x):
	multiplier = x
	$Sprite2D/Label.text = "x" + str(multiplier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detection_body_entered(body: Node2D) -> void:
	if (body.editor_description == "ball"):
		Plinko.set_money(round(Plinko.get_money() * multiplier * 100) / 100)
