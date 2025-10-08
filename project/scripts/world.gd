extends Node2D
class_name World


class ExerciseDisplay:
	var number : int
	var description : String
	var exercise_signal : Signal
	
	func _init(new_number : int, new_description : String, new_signal : Signal) -> void:
		number = new_number
		description = new_description
		exercise_signal = new_signal

signal generate_asteroids
signal start_satellite_orbits
signal rotate_mothership
signal shoot_missile
signal explode_asteroid
signal move_explorer_ship

const TIME_BETWEEN_EXERCISES := 2.5

var exercises : Array[ExerciseDisplay] = [
	ExerciseDisplay.new(5, "Générer procéduralement les astéroïdes.", generate_asteroids),
	ExerciseDisplay.new(2, "Décrire l'orbite d'un stallite.", start_satellite_orbits),
	ExerciseDisplay.new(3, "Faire tourner le vaisseau mère vers l'asteroïde obstacle.", rotate_mothership),
	ExerciseDisplay.new(4, "Tirer un missile sur l'astéroïde obstacle.", shoot_missile),
	ExerciseDisplay.new(6, "Faire exploser un astéroïde.", explode_asteroid),
	ExerciseDisplay.new(1, "Faire naviguer la sonde jusqu'à son objectif.", move_explorer_ship),
]


func _ready() -> void:
	Global.world = self
	$Grid/AnimationPlayer.play("grid_idle")
	play_exercise()

func play_exercise() -> void:
	await get_tree().create_timer(1.5).timeout
	
	for current_exercise : ExerciseDisplay in exercises:
		Global.player_camera.display_exercise(
			"Exercice " + str(current_exercise.number),
			current_exercise.description
		)
		await get_tree().create_timer(0.5).timeout
		current_exercise.exercise_signal.emit()
		await get_tree().create_timer(1.5).timeout
