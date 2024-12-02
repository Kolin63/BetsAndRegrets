extends Node2D


func _on_button_pressed():
	get_tree().change_scene_to_file("res://plinko.tscn")


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
