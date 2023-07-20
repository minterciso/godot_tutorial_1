extends CanvasLayer

signal start_game
signal easy
signal normal
signal hard

var current_locale = "US"

func _ready():
	change_locale("US")

func change_locale(locale):
	current_locale = locale
	TranslationServer.set_locale(locale)
	set_standard_texts()

func clean_levels():
	$Easy.hide()
	$Normal.hide()
	$Hard.hide()
	$LangBR.hide()
	$LangUS.hide()

func set_standard_texts():
	$StartButton.text = tr("START")
	$Easy.text = tr("LVL_EASY")
	$Normal.text = tr("LVL_NORMAL")
	$Hard.text = tr("LVL_HARD")
	$Message.text = tr("TITLE")
	$SelectedLevel.text = tr("LVL_EASY")

func reset_levels():
	$Easy.flat = true
	$Normal.flat = true
	$Hard.flat = true
	
func disable_level(level):
	if level == 'Easy':
		$Easy.flat = false
		$Normal.flat = true
		$Hard.flat = true
		$SelectedLevel.text = tr('LVL_EASY')
	elif level == 'Normal':
		$Easy.flat = true
		$Normal.flat = false
		$Hard.flat = true
		$SelectedLevel.text = tr('LVL_NORMAL')
	elif level == 'Hard':
		$Easy.flat = true
		$Normal.flat = true
		$Hard.flat = false
		$SelectedLevel.text = tr('LVL_HARD')

func show_message(text):
	$Message.text = tr(text)
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("GAME_OVER")
	await $MessageTimer.timeout
	
	$Message.text = tr("TITLE")
	$Message.show()
	# Make a one shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Easy.show()
	$Normal.show()
	$Hard.show()
	$LangUS.show()
	$LangBR.show()
	
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


func _on_lang_us_pressed():
	change_locale("US")


func _on_lang_br_pressed():
	change_locale("BR")
