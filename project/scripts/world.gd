extends Node2D
class_name World


signal explorer_ship_move

const TIME_BETWEEN_EXERCISES := 2.5



func _ready() -> void:
	Global.world = self
	$Grid/AnimationPlayer.play("grid_idle")
	play_exercise()

func play_exercise() -> void:
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 5",
		"Générer procéduralement les astéroïdes."
	)
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 2",
		"Décrire l'orbite d'un stallite."
	)
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 3",
		"Faire tourner le vaisseau mère vers l'asteroïde obstacle."
	)
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 4",
		"Tirer un missile sur l'astéroïde obstacle."
	)
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 6",
		"Détruire un astéroïde."
	)
	await get_tree().create_timer(TIME_BETWEEN_EXERCISES).timeout
	
	Global.player_camera.display_exercise(
		"Exercice 1",
		"Faire naviguer la sonde jusqu'à son objectif."
	)
