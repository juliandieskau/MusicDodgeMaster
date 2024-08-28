extends Node

var songs = ["House In A Forest","Camellia: Spider Dance","BTS: Spine Braker","Itro & Tobu: Cloud 9","J-Hope: Daydream","Jeon Jungkook: 2U","Red Army Choir: Soviet Anthem","Camellia - (This Track is) NOT EPIC"]
var muted = false
var current_song = 1
var music_volume = -8

func _ready():
	current_song = get_node("/root/variables").current_song

############################  CHANGE VOLUME  ############################

func StopMusic():
	if current_song == 0: $HouseInAForest.stop()
	if current_song == 1: $camelliaSpiderDance.stop()
	if current_song == 2: $btsSpineBraker.stop()
	if current_song == 3: $itrotobuCloud9.stop()
	if current_song == 4: $jhopeDaydream.stop()
	if current_song == 5: $jungkook2U.stop()
	if current_song == 6: $redarmychoirSovietAnthem.stop()
	if current_song == 7: $camelliaThisTrackIsNOTEPIC.stop()
	

func StartMusic():
	if current_song == 0: $HouseInAForest.play()
	if current_song == 1: $camelliaSpiderDance.play()
	if current_song == 2: $btsSpineBraker.play()
	if current_song == 3: $itrotobuCloud9.play()
	if current_song == 4: $jhopeDaydream.play()
	if current_song == 5: $jungkook2U.play()
	if current_song == 6: $redarmychoirSovietAnthem.play()
	if current_song == 7: $camelliaThisTrackIsNOTEPIC.play()
	print("plays camellia not epic")
	#print("Song: ", current_song)

func SetMusicVolume():
	muted = get_node("/root/variables").muted
	if (muted == true): 
		music_volume = -80
	if (muted == false):
		music_volume = -8
		#print(music_volume)
	#current_song = get_node("/root/variables").current_song
	#print(current_song)
	$HouseInAForest.volume_db = music_volume
	$camelliaSpiderDance.volume_db = music_volume
	$btsSpineBraker.volume_db = music_volume
	$itrotobuCloud9.volume_db = music_volume
	$jhopeDaydream.volume_db = music_volume
	$jungkook2U.volume_db = music_volume
	$redarmychoirSovietAnthem.volume_db = music_volume
	$camelliaThisTrackIsNOTEPIC.volume_db = music_volume
	#print("Camellia volume: ", $camelliaThisTrackIsNOTEPIC.volume_db)
	#print(music_volume)