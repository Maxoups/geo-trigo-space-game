extends Node



"""
FONCTIONS POUR VOUS AIDER:
	
	sin(r) 
		Donne le sinus de l'angle r en radians
	
	cos(r)
		Donne le cosinus de l'angle r en radians
	
	acos(c)
		Donne l'angle r dont cos(r) = c
	
	asin(s)
		Donne l'angle r dont sin(r) = s
	
	tan(r)
		Donne la tangente de l'angle r en radians
	
	atan2(y, x)
		Donne l'angle de tangente x, y
	
	sqrt(x) 
		Donne la racine carrée de x >= 0.0
	
	pow(x, i)
		Élève x à la puissance i
	
	Vector2(a, b).normalized() 
		Donne un vecteur de norme 1 colinéaire au vecteur Vector2(a, b)

"""



####### EXERCICE 1 #############################################################
# Faire naviguer l'ExplorerShip jusqu'à son objectif

# Interpoler la position de l'objet
func lerp_object_position(initial_position : Vector2, final_position : Vector2, 
						duration : float, time : float) -> Vector2:
	print_debug("À compléter")
	return Vector2.ZERO

# Interpoler la rotation de l'objet
func lerp_object_rotation(object_position : Vector2, next_object_position : Vector2) -> float:
	print_debug("À compléter")
	return 0.0



####### EXERCICE 2 #############################################################
# Décrire l'orbite d'un stallite

func get_satellite_orbit_parameters(orbit_center : Vector2, orbit_duration : float,
									stallite_position : Vector2) -> Dictionary[String, float]:
	print_debug("À compléter")
	return  {
		"radius"        : 0.0,
		"speed"         : 0.0,
		"current_angle" : 0.0
		}

func get_satellite_orbit_position(orbit_center : Vector2, orbit_radius : Vector2,
								orbit_speed : float, current_angle : float) -> Vector2:
	print_debug("À compléter")
	return Vector2.ZERO



####### EXERCICE 3 #############################################################
# Faire tourner le MotherShip vers l'asteroïde obstacle de l'ExplorerShip.

# Recréer la fonction get_angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	print_debug("À compléter")
	return 0.0



####### EXERCICE 4 #############################################################
# Détruire l'astéroïde obstacle

# Recréer la fonction get_direction_to()
# Pensez à bien retourner un vecteur NORMALISÉ!
func get_direction_to() -> Vector2:
	print_debug("À compléter")
	return Vector2.ZERO

# Donner la velocity = (direction * speed) du missile
# Bonus: utiliser current_velocity pour donner une accélération à l'objet. 
#        Si vous faites le bonus, pensez à retirer "_" de l'argument "_current_velocity".
func get_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, _current_velocity : Vector2) -> Vector2:
	return Vector2.ZERO


####### EXERCICE 5 #############################################################
# Générer procéduralement les astéroïdes

# Tracer un polygone régulier selon un centre, un rayon et un angle
func generate_polygon() -> void:
	pass



####### EXERCICE 6 #############################################################
# Détruire un astéroïde

# Fracturer un polygone en un nombre de fragments donnés
func shatter_polygon(polygon : Polygon2D, nb_fragments : int) -> Array[Polygon2D]:
	print_debug("À compléter")
	return []

# Exploser les fragments d'un polygone selon un point d'impact impact_point et 
# une vitesse speed
func explode_fragment(impact_point : Vector2, speed : float) -> Vector2:
	print_debug("À compléter")
	return Vector2.ZERO



####### BONUS: EXERCICE 7 ######################################################
# Shaders?
