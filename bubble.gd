extends Sprite2D


func _ready():
	visible = false


func say(text, audio):
	$Music.stop()
	visible = true
	$Label.text = text
	$AudioStreamPlayer2D.stream = audio
	$AudioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished() -> void:
	visible = false
	$Music.play()
