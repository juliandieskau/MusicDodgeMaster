extends CanvasLayer



func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func update_score(score):
	$ScoreLabel.text = str(score)
	get_node("/root/variables").score = str(score)
	print(get_node("/root/variables").score)


func _on_MessageTimer_timeout():
	$MessageLabel.hide()

