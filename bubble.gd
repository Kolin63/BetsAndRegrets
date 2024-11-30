extends Sprite2D

@onready var Music = $Music
@onready var Dialogue = $Dialogue

#var index = -1.0

func _ready():
	visible = false


func _process(delta):
	if (Input.is_action_just_pressed("right click") && $Dialogue.playing):
		$Dialogue.playing = false
		#_on_audio_stream_player_2d_finished()
		get_parent().DialogueManager.next_dia()


#func set_i(i):
	#index = i


#func get_i():
	#return index


func say(text, audio, i):
	#set_i(i)
	$Music.stream_paused = true
	visible = true
	$Speech.text = text
	$Speech.scroll()
	$Dialogue.stream = audio
	$Dialogue.play()

func _on_audio_stream_player_2d_finished() -> void:
	get_parent().DialogueManager.next_dia()


func stop_audio():
	$Dialogue.playing = false


func exit():
	visible = false
	$Music.stream_paused = false
	if ($Music.playing == false): $Music.play()
