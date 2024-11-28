extends Sprite2D

var index = -1

func _ready():
	visible = false


func _process(delta):
	if (Input.is_action_just_pressed("right click") && $Dialogue.playing):
		$Dialogue.playing = false
		_on_audio_stream_player_2d_finished()


func set_i(i):
	index = i


func get_i():
	return index


func say(text, audio, i):
	set_i(i)
	$Music.stream_paused = true
	visible = true
	$Speech.text = text
	$Speech.scroll()
	$Dialogue.stream = audio
	$Dialogue.play()

func _on_audio_stream_player_2d_finished() -> void:
	set_i(get_i() + 0.1)
	get_tree().current_scene.DialougeManager.dia(get_i())


func stop_audio():
	$Dialouge.playing = false


func exit():
	visible = false
	$Music.stream_paused = false
	if ($Music.playing == false): $Music.play()
