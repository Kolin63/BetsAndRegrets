extends Sprite2D

@onready var Music = $Music
@onready var Dialogue = $Dialogue


func _ready():
	visible = false


func _process(delta):
	if (Input.is_action_just_pressed("right click") && $Dialogue.playing):
		$Dialogue.playing = false
		get_parent().DialogueManager.next_dia()
	
	if ($Dialogue.playing):
		scroll()
	
	$RigidBody2D/CollisionShape2D.disabled = !visible


func say(text, audio, i, music = $Music.stream):
	visible = true
	
	$Speech.text = text
	
	$Dialogue.stream = audio
	$Dialogue.play()
	
	if (music == load("res://music/Dnd is satanic.mp3")):
		$Music.volume_db = 0
	else:
		$Music.volume_db = 0
	
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
	if ($Music.stream != load("res://music/The Devil Plays Plinko.mp3")):
		$Music.stream = load("res://music/The Devil Plays Plinko.mp3")
	if ($Music.playing == false): 
		$Music.play()


func scroll():
	var lines = $Speech.get_total_visible_line_count()
	var line_height = $Speech.get_line_height()
	
	var audio_length = $Dialogue.stream.get_length()
	
	var ratio = lines / audio_length
	
	
	var scroll = $Dialogue.get_playback_position() * ratio - 10
	$Speech.set_v_scroll(scroll)
