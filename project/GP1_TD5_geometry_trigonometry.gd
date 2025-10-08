extends Node



"""
FONCTIONS POUR VOUS AIDER:
	
	sqrt(x) 
		Donne la racine carrée de x >= 0.0
	
	pow(x, i)
		Élève x à la puissance i
	
	Vector2(a, b).normalized() 
		Donne un vecteur de norme 1 colinéaire au vecteur Vector2(a, b)

"""


# Exercice 2
# Décrire l'orbite d'un stallite
func get_satellite_orbit_parameters(orbit_center : Vector2, orbit_duration : float,
									stallite_position : Vector2) -> Array[float]:
	# Votre code ici
	# return [radius, speed, current_angle]
	return [0.0, 0.0, 0.0]

func get_satellite_orbit_position(orbit_center : Vector2, orbit_radius : float,
								orbit_speed : float, current_angle : float) -> Vector2:
	# votre code ici
	return Vector2.ZERO


# Exercice 3
# Recréer la fonction get_angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	# Votre code ici
	return 0.0


# Exercice ???
# Donner la velocity = (direction * speed) du missile
# Bonus: utiliser current_velocity pour donner une accélération au missile.
func get_missile_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, current_velocity := Vector2.ZERO) -> Vector2:
	return Vector2.ZERO
