extends Node

export (PackedScene) var Mob
var score = 0
#warning-ignore:unused_class_variable
var gameStarted = false
var PlayerName = "Player"
var spawnrate = 0.5
var time = 1

func _ready():
	#scaling()
	randomize()
	print("in Main")
	$Music.StartMusic()
	$Music.SetMusicVolume()
	new_game()

func _process(delta):
	spawnrate()
	$Music.SetMusicVolume()

func new_game():
	gameStarted = true
	get_node("/root/variables").directAfterGame = true
	get_node("/root/variables").gameStarted = gameStarted
	print("Game Started ",gameStarted)
	score = 0
	$gui.controls_offset()
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	
	
	

func game_over():
	print("Game over")
	$DeathSound.play()
	get_node("/root/variables").muted = false
	$Music.StopMusic()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$gui.controls_reset()
	get_node("/root/global").goto_scene("res://GameOver.tscn")

func _on_MobTimer_timeout():
	# choose a random location on the Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	time = score


############################  CHANGE SCALING  ############################
func scaling():
	#get_node("Camera2D").set_offset(get_node("HUD").scale / 2)
	get_node("Camera2D").set_zoom(get_node("Camera2D").get_zoom() / get_node("/root/global").viewport_scale)
	var HUD_scale = get_node("HUD")
	HUD_scale.set_scale(get_node("HUD").scale / get_node("/root/global").viewport_scale)
	print(get_node("HUD").scale)


############################  CHANGE SPAWN RATE  ############################
func spawnrate():
	var difficulty = get_node("/root/variables").difficulty
	match difficulty:
		1: spawnrate = 0.5 * exp(-0.02 * time) + 0.43
		2: spawnrate = 0.5 * exp(-0.02 * time) + 0.31
		3: spawnrate = 0.5 * exp(-0.02 * time) + 0.16
	get_node("MobTimer").wait_time = spawnrate
	#print(spawnrate)
