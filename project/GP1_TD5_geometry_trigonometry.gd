extends Node




# Exercice 2
#
func get_satellite_position(orbit_center : Vector2, orbit_duration : float,
							orbit_start : Vector2, current_time : float) -> Vector2:
	# Votre code ici
	return Vector2.ZERO


# Exercice 3
# Recréer la fonction get_angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	# Votre code ici
	return 0.0


# Exercice ???
# 
# Bonus: utiliser current_velocity pour donner une accélération au missile.
func get_missile_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, current_velocity := Vector2.ZERO) -> Vector2:
	return Vector2.ZERO
