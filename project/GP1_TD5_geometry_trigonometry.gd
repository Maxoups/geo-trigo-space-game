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


# Interpoler la rotation de l'objet pour qu'il garde une orientation correcte
# selon sa cible.
func lerp_object_rotation(object_rotation : float, object_position : Vector2,
							target_position : Vector2) -> float:
	# Si l'objet n'a pas de direction (ex: vitesse nulle), on ne change pas la rotation
	var dir := (target_position - object_position).normalized()
	if dir.length() == 0.0:
		return object_rotation
	var target_angle := atan2(dir.y, dir.x)
	# Interpolation fluide vers l'angle cible (rotation progressive)
	var rotate_speed := 3.0  # facteur de lissage (plus grand = plus rapide)
	var new_rotation := lerp_angle(object_rotation, target_angle, get_process_delta_time() * rotate_speed)
	return new_rotation
	
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

# Recréer la fonction angle_to()
func get_angle_to(object : Vector2, target : Vector2) -> float:
	# Vecteurs relatifs
	var diff := target - object
	
	# Retourner l’angle absolu entre (1,0) et diff
	return atan2(diff.y, diff.x)
	# Votre code ici
	return 0.0



####### EXERCICE 4 #############################################################
# Détruire l'astéroïde obstacle

# Recréer la fonction get_direction_to()
# Pensez à bien retourner un vecteur NORMALISÉ!
func get_direction_to(origin : Vector2, target : Vector2) -> Vector2:
	var dir := target - origin
	if dir.length() == 0.0:
		return Vector2.ZERO
	return dir.normalized()
	# Votre code ici
	return Vector2.ZERO


# Donner la velocity = (direction * speed) du missile
# Bonus: utiliser current_velocity pour donner une accélération à l'objet. 
#      Si vous faites le bonus, pensez à retirer "_" de l'argument "_current_velocity".
func get_velocity(position : Vector2, target_position : Vector2, speed : float, 
							delta : float, current_velocity : Vector2) -> Vector2:
	# direction normalisée vers la cible
	var direction := get_direction_to(position, target_position)
	# vitesse cible instantanée
	var desired_velocity := direction * speed * delta
	# BONUS : interpolation lissée pour simuler accélération / inertie
	var acceleration := 0.2  # facteur d’accéleration
	var new_velocity := current_velocity.lerp(desired_velocity, acceleration * delta)
	return new_velocity
	# Votre code ici
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
		a += randf_range(-angle_step * 0.1, angle_step * 0.1) # irrégularité sur l'angle
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
func shatter_polygon(polygon : PackedVector2Array,
						nb_fragments : int) -> Array[PackedVector2Array]:
	if polygon.size() < 3:
		push_error("polygon must have at least 3 points")
		return []
	if nb_fragments <= 0:
		push_error("nb_fragments must be >= 1")
		return []
	
	var n := polygon.size()
	# si on demande plus de fragments que de côtés, on limite au nombre de côtés
	if nb_fragments > n:
		nb_fragments = n
	# calcul d'un centroïde simple (moyenne des sommets)
	var centroid := Vector2.ZERO
	for p in polygon:
		centroid += p
	centroid /= float(n)
	# On crée n triangles (centroid, p[i], p[i+1]) en fan
	# Puis on regroupe des triangles contigus pour former chaque fragment.
	# Répartition équilibrée : certaines groupes auront (base+1) triangles si nécessaire.
	var base := n / nb_fragments        # division entière en GDScript donne float -> on convertit
	base = int(n / nb_fragments)
	var remainder := n % nb_fragments
	var fragments : Array = []
	var start := 0
	for group_index in range(nb_fragments):
		# déterminer combien de triangles dans ce groupe
		var k := base
		if group_index < remainder:
			k += 1  # répartir le reste sur les premiers groupes
		# un groupe de k triangles couvre k+1 sommets extérieurs consécutifs
		var frag_points := PackedVector2Array()
		# On ajoute le centroïde comme un sommet de l'éventail (cela produit des fragments en "fan")
		frag_points.append(centroid)
		# ajouter p[start] ... p[start + k] (mod n)
		for j in range(k + 1):
			var idx := (start + j) % n
			frag_points.append(polygon[idx])
		fragments.append(frag_points)
		# avancer le pointeur de départ par k triangles
		start += k
	return fragments
	
	# Votre code ici
	return []


# Renvoie la velocité d'un fragment d'un polygone explosé selon un point 
# d'impact et une force
func explode_fragment(fragment_position : Vector2, impact_point : Vector2, 
						force : float) -> Vector2:
	# direction du fragment depuis le point d'impact
	var dir := fragment_position - impact_point
	var dist := dir.length()
	# cas limite : si le fragment est exactement au point d'impact,
	# choisir une direction fixe
	if dist < 0.0001:
		dir = Vector2(0, -1)
		dist = 1.0
	dir = dir / dist  # normaliser
	# atténuation selon la distance : on veut une décroissance douce
	# (1 / (1 + dist)) fonctionne bien pour des distances en pixels.
	var attenuation := 1.0 / (1.0 + dist)
	# ajouter un petit jitter angulaire pour varier les trajectoires (le game feel c'est bien)
	var jitter := randf_range(-PI * 0.08, PI * 0.08)
	dir = dir.rotated(jitter)
	# composante tangentielle aléatoire pour effet de rotation/éparpillement
	var tangent := Vector2(-dir.y, dir.x) * randf_range(-0.35, 0.35)
	# calcul final de la vélocité
	var velocity := dir * force * attenuation + tangent * force * 0.2
	return velocity
	
	# Votre code ici
	return Vector2.ZERO



####### BONUS: EXERCICE 7 ######################################################
# Shaders?
