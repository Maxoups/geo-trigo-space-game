extends Node



"""
Appuyer sur F5 pour lancer un test.
Dans le test, appuyer sur Tab pour afficher/enlever les données de la grille.
Les exercices se joueront automatiquement.

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
						speed : float, current_time : float) -> Vector2:
	
	# Votre code ici
	return Vector2.ZERO

# Interpoler la rotation de l'objet
func lerp_object_rotation(object_position : Vector2, next_object_position : Vector2) -> float:
	# Votre code ici
	return 0.0



####### EXERCICE 2 #############################################################
# Décrire l'orbite d'un stallite

# Calculer les paramètre de l'orbite d'un satellite (qu'=e l'on suppose être 
# toujours un cercle parfait).
func get_satellite_orbit_parameters(orbit_center : Vector2, orbit_duration : float,
									satellite_position : Vector2) -> Dictionary[String, float]:
	var radius_vec := satellite_position - orbit_center
	var radius := radius_vec.length()
	# Starting angle in radians, measured from +X axis
	var starting_angle := radius_vec.angle()
	# Optional: orbital speed (radians per second for one full revolution)
	var speed := TAU / orbit_duration
	return {
		"radius": radius,
		"speed": speed,
		"starting_angle": starting_angle
	}
	# Votre code ici
	return  {
		"radius"        : 0.0,
		"speed"         : 0.0,
		"starting_angle" : 0.0
		}

# Calculer la position et la rotation d'un satellite sur son orbite selon un 
# angle donné.
# Attention au rayon de l'orbite : c'est un vecteur (x, y). La trajectoire
# décrite peut donc être une ellipse si x != y !
func get_satellite_orbit_transform(orbit_center : Vector2, starting_angle : float,
		orbit_radius : Vector2, orbit_duration : float, current_time : float) -> Transform2D:
	var current_angle := starting_angle + (current_time / orbit_duration) * TAU
	# Compute position along the elliptical orbit
	var current_pos := orbit_center + Vector2(
		cos(current_angle) * orbit_radius.x,
		sin(current_angle) * orbit_radius.y
	)
	# Calcul du vecteur de vélocité à l'instant t (dérivé de la position)
	var vel := Vector2(
		-sin(current_angle) * orbit_radius.x,
		 cos(current_angle) * orbit_radius.y
	)
	# Calcul de l'orientation du satellite (tangente de la vitesse)
	var rotation := vel.angle()
	return Transform2D(rotation, current_pos)
	# Votre code ici
	return Transform2D(
		0.0,          # satellite rotation
		Vector2.ZERO  # stallite position
	)



####### EXERCICE 3 #############################################################
# Faire tourner le MotherShip vers l'asteroïde obstacle de l'ExplorerShip.

# Recréer la fonction get_angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	# Votre code ici
	return 0.0



####### EXERCICE 4 #############################################################
# Détruire l'astéroïde obstacle

# Recréer la fonction get_direction_to()
# Pensez à bien retourner un vecteur NORMALISÉ!
func get_direction_to() -> Vector2:
	# Votre code ici
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
	# Votre code ici
	return []

# Exploser les fragments d'un polygone selon un point d'impact impact_point et 
# une vitesse speed
func explode_fragment(impact_point : Vector2, speed : float) -> Vector2:
	# Votre code ici
	return Vector2.ZERO



####### BONUS: EXERCICE 7 ######################################################
# Shaders?
