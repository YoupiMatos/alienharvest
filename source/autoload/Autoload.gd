extends Node

# levels completion
var base_complete = false
var level_1_complete = false
var level_2_complete = false
var level_3_complete = false

func cut_audio():
	$AudioStreamPlayer.stop()

func begin_last_song():
	$AudioStreamPlayer2.play()
