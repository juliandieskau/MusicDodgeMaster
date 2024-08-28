extends Node

var inStartMenu = true
var PlayerName = ""
var gameStarted = false
var score = 0
var gameCounter = 0
var missingScoreText = ""
var directAfterGame = true
var difficulty = 1
var muted = false
var current_song = 1
var songs = ["House In A Forest","Camellia: Spider Dance","BTS: Spine Braker","Itro & Tobu: Cloud 9","J-Hope: Daydream","Jeon Jungkook: 2U","Red Army Choir: Soviet Anthem","Camellia - (This Track is) NOT EPIC"]
var gameCounterNormal = 0
var highscoreListeNormal = [[0, "Player"], [0, "Player"], [0, "Player"]]
var gameCounterHard = 0
var highscoreListeHard = [[0, "Player"], [0, "Player"], [0, "Player"]]
var gameCounterInsane = 0
var highscoreListeInsane = [[0, "Player"], [0, "Player"], [0, "Player"]]
var difficultyTab = 1

const SAVE_PATH = "res://save.json"


func _ready():
	pass 


func save_game():
	var save_file = File.new()
	var save_dict = {}
	# Get all the save data from persitent nodes
	var nodes_to_save = get_tree().get_nodes_in_group("Persistent")
	print("Nodes to save: ", nodes_to_save)
	
	for node in nodes_to_save:
		var node_data = node.call("save")
		save_file.store_line(to_json(node_data))
		save_dict[node.get_path()] = node.save()
		print(node.get_path())
		#print(save_dict)
		pass

	# Create a file
	save_file.open(SAVE_PATH, File.WRITE)

	# Serialize the data dictionary to JSON
	save_file.store_line(to_json(save_dict))

	# Write the JSON to the file and save to disk
	save_file.close()
	print("game saved!")
	pass


func save():
	var save_dict = {
		gameCounter=gameCounter,
		gameCounterNormal=gameCounterNormal,
		gameCounterHard=gameCounterHard,
		gameCounterInsane=gameCounterInsane,
		highscoreListeNormal=highscoreListeNormal,
		highscoreListeHard=highscoreListeHard,
		highscoreListeInsane=highscoreListeInsane,
		PlayerName=PlayerName,
		current_song=current_song
	}
	return save_dict