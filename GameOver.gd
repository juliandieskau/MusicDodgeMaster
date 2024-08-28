extends Node2D

var gameCounter = 0
var gameCounterNormal = 0
var gameCounterHard = 0
var gameCounterInsane = 0
var highscoreListeNormal = [[0, "Player"], [0, "Player"], [0, "Player"]]
var highscoreListeHard = [[0, "Player"], [0, "Player"], [0, "Player"]]
var highscoreListeInsane = [[0, "Player"], [0, "Player"], [0, "Player"]]
var score = 0
var highscore = 0
var missingScore = 0
var PlayerName = ""
var difficulty = 1
var current_song = ""

const SAVE_PATH = "res://save.json"

class MyCustomSorter:
    static func sort(a, b): #erzeugt die function bereits ohne "new()"
        if a[0] > b[0]: 
            return true
        return false

func _ready():
	get_node("/root/variables").inStartMenu = false
	score = int(get_node("/root/variables").score)
	PlayerName = get_node("/root/variables").PlayerName
	highscoreListeNormal = get_node("/root/variables").highscoreListeNormal
	highscoreListeHard = get_node("/root/variables").highscoreListeHard
	highscoreListeInsane = get_node("/root/variables").highscoreListeInsane
	gameCounter = get_node("/root/variables").gameCounter
	gameCounterNormal = get_node("/root/variables").gameCounterNormal
	gameCounterHard = get_node("/root/variables").gameCounterHard
	gameCounterInsane = get_node("/root/variables").gameCounterInsane
	$MissingScore.text = get_node("/root/variables").missingScoreText
	current_song = get_node("/root/variables").current_song
	get_node("/root/variables").inStartMenu = false
	difficulty = get_node("/root/variables").difficulty 
	print("difficulty: ", difficulty)
	afterGame()


func _on_Statistics_pressed():
	get_node("/root/global").goto_scene("res://Statistics.tscn")
	get_node("/root/variables").directAfterGame = false

func _on_MainMenu_pressed():
	get_node("/root/global").goto_scene("res://StartMenu.tscn")
	get_node("/root/variables").directAfterGame = false

func afterGame():
	print("after game called")
	var directAfterGame = get_node("/root/variables").directAfterGame
	if (directAfterGame == true):
		print("direct after game = true")
		countGames()
		sortHighscores()
		missingToHighscore()
		#save_game()
		get_node("/root/variables").save_game()
	if (directAfterGame == false):
		pass


func countGames():
	print("count games called")
	gameCounter = get_node("/root/variables").gameCounter + 1
	match difficulty:
		1: 
			gameCounterNormal = get_node("/root/variables").gameCounterNormal + 1
			get_node("/root/variables").gameCounterNormal = gameCounterNormal
			print("normal games: ", gameCounterNormal)
			highscoreListeNormal.append([score, PlayerName])
		2: 
			gameCounterHard = get_node("/root/variables").gameCounterHard + 1
			get_node("/root/variables").gameCounterHard = gameCounterHard
			print("hard games: ", gameCounterHard)
			highscoreListeHard.append([score, PlayerName])
		3: 
			gameCounterInsane = get_node("/root/variables").gameCounterInsane + 1
			get_node("/root/variables").gameCounterInsane = gameCounterInsane
			print("insane games: ", gameCounterInsane)
			highscoreListeInsane.append([score, PlayerName])
	
	get_node("/root/variables").gameCounter = gameCounter
	print("Games played: ", gameCounter)


func sortHighscores():
	highscoreListeNormal.sort_custom(MyCustomSorter, "sort")
	highscoreListeHard.sort_custom(MyCustomSorter, "sort")
	highscoreListeInsane.sort_custom(MyCustomSorter, "sort")
	get_node("/root/variables").highscoreListeNormal = highscoreListeNormal
	get_node("/root/variables").highscoreListeHard = highscoreListeHard
	get_node("/root/variables").highscoreListeInsane = highscoreListeInsane

func missingToHighscore():
	var secondScore = 0
	match difficulty:
		1: 
			highscore = highscoreListeNormal[0][0]
			secondScore = highscoreListeNormal[1][0]
		2: 
			highscore = highscoreListeHard[0][0]
			secondScore = highscoreListeHard[1][0]
		3: 
			highscore = highscoreListeInsane[0][0]
			secondScore = highscoreListeInsane[1][0]
	print("Highscore: ", highscore)
	missingScore = highscore - score
	print("MissingScore: ", missingScore)
	if (missingScore == 0):
		if (secondScore == score):
			$MissingScore.text = "Just one more needed :c"
		else:
			$MissingScore.text = "New Highscore!"
	elif (missingScore < 0):
		$MissingScore.text = "New Highscore!"
	elif (missingScore > 0):
		$MissingScore.text = "Score missing to Highscore: " + String(missingScore)
	get_node("/root/variables").missingScoreText = $MissingScore.text
	print(get_node("/root/variables").missingScoreText)

#func save_game():
#	var save_file = File.new()
#	var save_dict = {}
#	# Get all the save data from persitent nodes
#	var nodes_to_save = get_tree().get_nodes_in_group("Persistent")
#	print("Nodes to save: ", nodes_to_save)
#
#	for node in nodes_to_save:
#		var node_data = node.call("save")
#		save_file.store_line(to_json(node_data))
#		save_dict[node.get_path()] = node.save()
#		print(node.get_path())
#		pass
#
#	# Create a file
#	save_file.open(SAVE_PATH, File.WRITE)
#
#	# Serialize the data dictionary to JSON
#	save_file.store_line(to_json(save_dict))
#
#	# Write the JSON to the file and save to disk
#	save_file.close()
#	print("game saved!")
#	pass

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