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



# Exercice 1
# Faire naviguer l'ExplorerShip jusqu'à son objectif

# Donner la velocity = (direction * speed) de l'objet (ExplorerShip)
# Bonus: utiliser current_velocity pour donner une accélération à l'objet. 
#        Si vous faites le bonus, pensez à retirer "_" de l'argument "_current_velocity".
func get_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, _current_velocity : Vector2) -> Vector2:
	return Vector2.ZERO



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
# Faire tourner le MotherShip vers l'asteroïde obstacle de l'ExplorerShip.

# Recréer la fonction get_angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	# Votre code ici
	return 0.0



# Exercice 4
# Détruire l'astéroïde obstacle

# Recréer la fonction get_direction_to()
# Pensez à bien retourner un vecteur NORMALISÉ!
func get_direction_to() -> Vector2:
	# Votre code ici
	return Vector2.ZERO



# Exercice 5
# Générer procéduralement un astéroïde

# Tracer un polygone régulier selon un centre, un rayon et un angle
func generate_polygone() -> void:
	pass



# Exercice 6 
# Détruire un astéroïde

# Fracturer un polygone en un nombre de fragments donnés
func shatter_polygon(polygon : Polygon2D, fragments : int) -> Array[Polygon2D]:
	# votre code ici
	return []

# Exploser les fragments d'un polygone selon un point d'impact impact_point et 
# une vitesse speed
func explode_fragment(impact_point : Vector2, speed : float) -> Vector2:
	# votre code ici
	return Vector2.ZERO
