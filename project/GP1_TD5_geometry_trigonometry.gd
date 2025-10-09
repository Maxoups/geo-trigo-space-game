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
	
	Vector2(a, b).angle_to(Vector2(c, d))
		Retourne l'angle entre le Vecteur(A, B) et le Vecteur(C, D)

"""



####### EXERCICE 1 #############################################################
# Faire naviguer l'ExplorerShip jusqu'à son objectif

# Interpoler la position de l'objet
func lerp_object_position(initial_position : Vector2, final_position : Vector2, 
						speed : float, current_time : float) -> Vector2:
	var dist : float = initial_position.distance_to(final_position)
	var total_time : float = dist / speed
	var progress : float = min(1.0, current_time / total_time)
	return initial_position * (1-progress) + final_position * (progress)
	# Votre code ici
	return Vector2.ZERO

# Interpoler la rotation de l'objet (donner l'angle entre l'objet et sa position
# suivante)
func lerp_object_rotation(object_position : Vector2, next_object_position : Vector2) -> float:
	return object_position.angle_to(next_object_position)
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
	print_debug("RECREER LA FONCTION GET_ANGLE_TO")
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
#      Si vous faites le bonus, pensez à retirer "_" de l'argument "_current_velocity".
func get_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, _current_velocity : Vector2) -> Vector2:
	return Vector2.ZERO


####### EXERCICE 5 #############################################################
# Générer procéduralement les astéroïdes

# Tracer un polygone régulier selon un rayon et un nombre de côtés
func generate_regular_polygon(radius : float, number_of_sides : int) -> PackedVector2Array:
	if number_of_sides < 3:
		push_error("number_of_sides must be at least 3")
		return []
	if radius <= 0.0:
		push_error("radius must be > 0")
		return []
	
	var points: PackedVector2Array = PackedVector2Array()
	var angle_step := (TAU) / float(number_of_sides) # TAU = PI * 2
	# Optionnel : démarrer en haut (−PI/2) pour que le premier sommet soit vers le haut
	var start_angle := -PI * 0.5
	for i in range(number_of_sides):
		var a := start_angle + angle_step * i
		var p := Vector2(cos(a), sin(a)) * radius
		points.append(p)
	return points

	# Votre code ici
	return []

# Tracer un polygone quelconque selon un nombre de côtés, un rayon exterieur et un
# rayon intérieur. Tous les points du polygons doivent être entre les deux rayons.
func generate_random_polygon(external_radius : float, internal_radius : float,
							number_of_sides : int) -> PackedVector2Array:
	if number_of_sides < 3:
		push_error("number_of_sides must be at least 3")
		return []
	if internal_radius <= 0.0 or external_radius <= internal_radius:
		push_error("Invalid radius values: external must be > internal > 0")
		return []
	
	
	var points: PackedVector2Array = PackedVector2Array()
	var angle_step := (TAU) / float(number_of_sides) # TAU = PI * 2
	var start_angle := -PI * 0.5  # pour commencer vers le haut
	
	for i in range(number_of_sides):
		var a := start_angle + angle_step * i
		a += randf_range(-angle_step * 0.2, angle_step * 0.2) # irrégularité sur l'angle
		# Rayon aléatoire entre les deux bornes
		var r := randf_range(internal_radius, external_radius)
		var p := Vector2(cos(a), sin(a)) * r
		points.append(p)

	return points
	# Votre code ici
	return []


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
