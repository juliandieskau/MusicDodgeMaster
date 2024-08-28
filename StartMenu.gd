extends Node2D

signal delete_name

var PlayerName = ""
var difficulty = 1

func _ready():
	print("in StartMenu")
	#print("PlayerName: ", PlayerName)
	$SetName.text = get_node("/root/variables").PlayerName
	get_node("/root/variables").inStartMenu = true
	difficulty = get_node("/root/variables").difficulty
	if difficulty == 1: $DifficultyLabel.text = "Difficulty: Normal"
	if difficulty == 2: $DifficultyLabel.text = "Difficulty: Hard"
	if difficulty == 3: $DifficultyLabel.text = "Difficulty: Insane"


func _on_DeleteName_pressed():
	emit_signal("delete_name")
	$SetName.text = ""


func _on_Statistics_pressed():
	getPlayerName()
	get_node("/root/global").goto_scene("res://Statistics.tscn")
	


func _on_StartGame_pressed():
	getPlayerName()
	get_node("/root/variables").gameStarted = true
	get_node("/root/global").goto_scene("res://Main.tscn")
	


func getPlayerName():
	PlayerName = $SetName.text
	if (PlayerName == ""):
		PlayerName = "Player"
	print("PlayerName: ", PlayerName)
	get_node("/root/variables").PlayerName = PlayerName

func _on_Settings_pressed():
	get_node("/root/global").goto_scene("res://settings.tscn")
