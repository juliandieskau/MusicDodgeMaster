extends Node2D

var sound_muted = false

#################################################

func _ready():
	pass 

#################################################

func pauseMenuOpen():
	$Menu.show()
	$FilterNode.show()
	sound_muted = get_node("/root/variables").muted
	get_tree().paused = true
	if (sound_muted == true):
		$Menu/SoundmuteButton/muteSymbol.hide()
		$Menu/SoundmuteButton/unmuteSymbol.show()
	pass


func pauseMenuClose():
	$Menu.hide()
	$FilterNode.hide()
	get_tree().paused = false
	pass


func SoundMute():
	get_node("/root/variables").muted = true
	pass

func SoundUnmute():
	get_node("/root/variables").muted = false
	pass

#################################################

func _on_Pause_pressed():
	$inHUD/Pause/normalTexture.show()
	$inHUD/Pause/pressedTexture.hide()
	pauseMenuOpen()
	pass


func _on_ResumeButton_pressed():
	pauseMenuClose()
	pass


func _on_SoundmuteButton_pressed():
	if (sound_muted == false):
		SoundMute()
		sound_muted = true
		$Menu/SoundmuteButton/muteSymbol.hide()
		$Menu/SoundmuteButton/unmuteSymbol.show()
		print("Sound muted: ", sound_muted)
	else: 
		SoundUnmute()
		sound_muted = false
		$Menu/SoundmuteButton/muteSymbol.show()
		$Menu/SoundmuteButton/unmuteSymbol.hide()
		print("Sound muted: ", sound_muted)
