extends Sprite2D

@onready var Music = $Music
@onready var Dialogue = $Dialogue


func _ready():
	visible = false


func _process(delta):
	if (Input.is_action_just_pressed("right click") && $Dialogue.playing):
		$Dialogue.playing = false
		get_parent().DialogueManager.next_dia()


func say(text, audio, i, music = $Music.stream):
	visible = true
	
	$Speech.text = text
	$Speech.scroll()
	
	$Dialogue.stream = audio
	$Dialogue.play()
	
	if (music == null):
		$Music.stream_paused = true
	elif (music == $Music.stream && $Music.playing):
		pass
	else:
		$Music.stream = music
		$Music.play()


func _on_audio_stream_player_2d_finished() -> void:
	get_parent().DialogueManager.next_dia()


func stop_audio():
	$Dialogue.playing = false


func exit():
	visible = false
	$Music.stream_paused = false
	$Music.stream = load("res://The Devil Plays Plinko.mp3")
	if ($Music.playing == false): $Music.play()
