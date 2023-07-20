extends CanvasLayer

signal start_game
signal easy
signal normal
signal hard

func clean_levels():
	$Easy.hide()
	$Normal.hide()
	$Hard.hide()

func reset_levels():
	$Easy.flat = true
	$Normal.flat = true
	$Hard.flat = true
	
func disable_level(level):
	if level == 'Easy':
		$Easy.flat = false
		$Normal.flat = true
		$Hard.flat = true
		$SelectedLevel.text = 'Easy'
	elif level == 'Normal':
		$Easy.flat = true
		$Normal.flat = false
		$Hard.flat = true
		$SelectedLevel.text = 'Normal'
	elif level == 'Hard':
		$Easy.flat = true
		$Normal.flat = true
		$Hard.flat = false
		$SelectedLevel.text = 'Hard'

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the \nCreeps!"
	$Message.show()
	# Make a one shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Easy.show()
	$Normal.show()
	$Hard.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	

func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_easy_pressed():
	easy.emit()
	

func _on_normal_pressed():
	normal.emit()


func _on_hard_pressed():
	hard.emit()
