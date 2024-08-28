extends Node2D

var difficulty = 1
var current_song = 1
var songs = ["House In A Forest","Camellia: Spider Dance","BTS: Spine Braker","Itro & Tobu: Cloud 9","J-Hope: Daydream","Jeon Jungkook: 2U","Red Army Choir: Soviet Anthem","Camellia - (This Track is) NOT EPIC"]
var song_name = ""

func _ready():
	current_song = get_node("/root/variables").current_song
	songs = get_node("/root/variables").songs
	getSongName()
	get_node("sound/songs/songLabel").text = song_name
	difficulty = get_node("/root/variables").difficulty
	if difficulty == 1: _on_normalButton_pressed()
	if difficulty == 2: _on_hardButton_pressed()
	if difficulty == 3: _on_insaneButton_pressed()
	


############################  CHANGE SONG  ############################
func _on_previousButton_pressed():
	if (current_song > 0):
		current_song = current_song -1
		getSongName()
		get_node("sound/songs/songLabel").text = song_name
	else:
		current_song = 7
		getSongName()
		get_node("sound/songs/songLabel").text = song_name
	get_node("/root/variables").current_song = current_song


func _on_nextButton_pressed():
	if (current_song < 7):
		current_song = current_song + 1
		getSongName()
		get_node("sound/songs/songLabel").text = song_name
	else:
		current_song = 0
		getSongName()
		get_node("sound/songs/songLabel").text = song_name
	get_node("/root/variables").current_song = current_song


func getSongName():
	song_name = songs[current_song]
	print(song_name)


############################  CHANGE VOLUME  ############################
func _on_muteButton_pressed():
	get_node("/root/variables").muted = true


func _on_unmuteButton_pressed():
	get_node("/root/variables").muted = false


############################  CHANGE DIFFICULTY  ############################
func _on_normalButton_pressed():
	difficulty = 1
	get_node("/root/variables").difficulty = difficulty
	$difficulty/normalButton.hide()
	$difficulty/hardButton.show()
	$difficulty/insaneButton.show()
	$difficulty/normalLabel.show()
	$difficulty/hardLabel.hide()
	$difficulty/insaneLabel.hide()
	print("difficulty normal")


func _on_hardButton_pressed():
	difficulty = 2
	get_node("/root/variables").difficulty = difficulty
	$difficulty/normalButton.show()
	$difficulty/hardButton.hide()
	$difficulty/insaneButton.show()
	$difficulty/normalLabel.hide()
	$difficulty/hardLabel.show()
	$difficulty/insaneLabel.hide()
	print("difficulty hard")


func _on_insaneButton_pressed():
	difficulty = 3
	get_node("/root/variables").difficulty = difficulty
	$difficulty/normalButton.show()
	$difficulty/hardButton.show()
	$difficulty/insaneButton.hide()
	$difficulty/normalLabel.hide()
	$difficulty/hardLabel.hide()
	$difficulty/insaneLabel.show()
	print("difficulty insane")


############################  LEAVE SETTINGS  ############################
func _on_leaveButton_pressed():
	get_node("/root/global").goto_scene("res://StartMenu.tscn")
