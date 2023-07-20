extends Node

@export var mob_scene: PackedScene
var difficulty = 1
var score
	

func set_difficulty_easy():
	difficulty = 1
	$HUD.disable_level('Easy')
	$MobTimer.wait_time = 1
	
func set_difficulty_normal():
	difficulty = 2
	$HUD.disable_level('Normal')
	$MobTimer.wait_time = 0.5

func set_difficulty_hard():
	difficulty = 3
	$HUD.disable_level('Hard')
	$MobTimer.wait_time = 0.25

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$HUD.reset_levels()

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("READY")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	$HUD.clean_levels()


func _on_mob_timer_timeout():
	# Create a new instance of the mob scene
	var mob = mob_scene.instantiate()
	
	# Chose a random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the mob direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location
	mob.position = mob_spawn_location.position
	
	# Add some randomnes to the direction
	direction = randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose the velocity for the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) * difficulty
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding it to the Main Scene
	add_child(mob)
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
