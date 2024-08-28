extends Node2D

var gameCounter = 0
var gameCounterNormal = 0
var highscoreListeNormal = [[0, "Player"], [0, "Player"], [0, "Player"]]
var gameCounterHard = 0
var highscoreListeHard = [[0, "Player"], [0, "Player"], [0, "Player"]]
var gameCounterInsane = 0
var highscoreListeInsane = [[0, "Player"], [0, "Player"], [0, "Player"]]
var difficulty = 1
var difficultyTab = 1



func _ready():
	highscoreListeNormal = get_node("/root/variables").highscoreListeNormal
	highscoreListeHard = get_node("/root/variables").highscoreListeHard
	highscoreListeInsane = get_node("/root/variables").highscoreListeInsane
	gameCounter = get_node("/root/variables").gameCounter
	gameCounterNormal = get_node("/root/variables").gameCounterNormal
	gameCounterHard = get_node("/root/variables").gameCounterHard
	gameCounterInsane = get_node("/root/variables").gameCounterInsane
	difficulty = get_node("/root/variables").difficulty
	
	print("in Statistics")
	difficultyMatch()
	SetText()
	ShowStatsLabels()


func ShowStatsLabels():
	if (gameCounter == 0):
		$NoGames.show()
		$Stats1.hide()
		$Stats2.hide()
		$Stats3.hide()
	elif (gameCounter == 1):
		$NoGames.hide()
		$Stats1.show()
		$Stats2.hide()
		$Stats3.hide()
	elif (gameCounter == 2):
		$NoGames.hide()
		$Stats1.show()
		$Stats2.show()
		$Stats3.hide()
	else:
		$NoGames.hide()
		$Stats1.show()
		$Stats2.show()
		$Stats3.show()


func difficultyMatch():
	match difficulty:
		1:
			normalTab()
			gameCounter = gameCounterNormal
			print("games played normal: ", gameCounter)
		2:
			hardTab()
			gameCounter = gameCounterHard
			print("games played hard: ", gameCounter)
		3:
			insaneTab()
			gameCounter = gameCounterInsane
			print("games played insane: ", gameCounter)


func normalTab():
	$Normal.hide()
	$Hard.show()
	$Insane.show()
	$NormalLabel.show()
	$HardLabel.hide()
	$InsaneLabel.hide()
	difficultyTab = 1
	print("difficulty Tab: ", difficultyTab)

func hardTab():
	$Normal.show()
	$Hard.hide()
	$Insane.show()
	$NormalLabel.hide()
	$HardLabel.show()
	$InsaneLabel.hide()
	difficultyTab = 2
	print("difficulty Tab: ", difficultyTab)

func insaneTab():
	$Normal.show()
	$Hard.show()
	$Insane.hide()
	$NormalLabel.hide()
	$HardLabel.hide()
	$InsaneLabel.show()
	difficultyTab = 3
	print("difficulty Tab: ", difficultyTab)


func _on_LeaveStats_pressed():
	pass # Replace with function body.
	var inStartMenu = get_node("/root/variables").inStartMenu
	if (inStartMenu == true):
		get_node("/root/global").goto_scene("res://StartMenu.tscn")
	if (inStartMenu == false):
		get_node("/root/global").goto_scene("res://GameOver.tscn")


func SetText():
	var highscoreListe = []
	match difficultyTab:
		1:
			highscoreListe = highscoreListeNormal
			print(highscoreListe)
			print(highscoreListeNormal)
		2:
			highscoreListe = highscoreListeHard
			print(highscoreListe)
			print(highscoreListeHard)
		3:
			highscoreListe = highscoreListeInsane
			print(highscoreListe)
			print(highscoreListeInsane)
	
	var StatsText1 = ""
	var StatsText2 = ""
	var StatsText3 = ""
	StatsText1 = StatsText1 + str(highscoreListe[0][1],": ",highscoreListe[0][0])
	StatsText2 = StatsText2 + str(highscoreListe[1][1],": ",highscoreListe[1][0])
	StatsText3 = StatsText3 + str(highscoreListe[2][1],": ",highscoreListe[2][0])
	$Stats1.text = StatsText1
	$Stats2.text = StatsText2
	$Stats3.text = StatsText3


func _on_Normal_pressed():
	print("normal pressed")
	difficulty = 1
	difficultyMatch()
	ShowStatsLabels()
	SetText()


func _on_Hard_pressed():
	print("hard pressed")
	difficulty = 2
	difficultyMatch()
	ShowStatsLabels()
	SetText()


func _on_Insane_pressed():
	difficulty = 3
	print("insane pressed")
	difficultyMatch()
	ShowStatsLabels()
	SetText()
