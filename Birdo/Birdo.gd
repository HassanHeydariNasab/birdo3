extends KinematicBody

onready var Birdo = get_node(".")
onready var Animo = get_node("Modelo/animation_player")
onready var os = OS.get_name()
onready var Grako_1 = get_node("Grako_1")
onready var Grako_2 = get_node("Grako_2")
onready var Grako_3 = get_node("Grako_3")
onready var Grakoj = [Grako_1, Grako_2, Grako_3]
onready var Klapo_1 = get_node("Klapo_1")
onready var Klapo_2 = get_node("Klapo_2")
onready var Klapoj = [Klapo_1, Klapo_2]
onready var Vento = get_node("Vento")

var movo = Vector3(0,0,0)
const angula_rapido = 0.025
const RAPIDO = 12
var rapido = 12
const a = 0.01

func _ready():
	Animo.play("malfermaj_flugiloj")
	set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("flugi"):
		Vento.set_volume_db(lerp(Vento.get_volume_db(), rapido-45, 0.5))
		if Animo.get_current_animation() != "flugado":
			Animo.play("flugado")
	elif Input.is_action_just_released("flugi"):
		Klapo_1.stop()
		Klapo_2.stop()
		Animo.play("malfermaj_flugiloj")
		if Input.is_action_pressed("supre"):
			Animo.play("malfermaj_flugiloj_supre")
		elif Input.is_action_pressed("malsupre"):
			Animo.play("malfermaj_flugiloj_malsupre")
	elif Input.is_action_just_pressed("supre"):
		Animo.play("malfermaj_flugiloj_supre")
	elif Input.is_action_just_pressed("malsupre"):
		Animo.play("malfermaj_flugiloj_malsupre")
	elif not Input.is_action_pressed("flugi"):
		Vento.set_volume_db(lerp(Vento.get_volume_db(), rapido-33, 0.3))
		if not (Input.is_action_pressed("supre") or Input.is_action_pressed("malsupre")):
			Klapo_1.stop()
			Klapo_2.stop()
			if Animo.get_current_animation() != "malfermaj_flugiloj":
				Animo.play("malfermaj_flugiloj")

func _input(evento):
	if evento.is_action_pressed("graki"):
		randomize()
		Grakoj[int(rand_range(0,3))].play()

func _physics_process(delta):
	if Input.is_action_pressed("supre"):
		Birdo.rotate_object_local(Vector3(-1,0,0),angula_rapido)
	if Input.is_action_pressed("malsupre"):
		Birdo.rotate_object_local(Vector3(1,0,0),angula_rapido)
	if Input.is_action_pressed("dekstre"):
		Birdo.rotate_object_local(Vector3(0,0,-1),angula_rapido)
	if Input.is_action_pressed("maldekstre"):
		Birdo.rotate_object_local(Vector3(0,0,1),angula_rapido)
	if Input.is_action_pressed("dekstre2"):
		Birdo.rotate_object_local(Vector3(0,-1,0),angula_rapido/2)
	if Input.is_action_pressed("maldekstre2"):
		Birdo.rotate_object_local(Vector3(0,1,0),angula_rapido/2)
	movo = Vector3(0,0,0)
	var t = Birdo.get_transform().basis.z.normalized()
	var x = t.x
	var y = t.y
	var z = t.z
#	if os == "Android":
#		var akc = Input.get_accelerometer()
#		Birdo.rotate_object_local(Vector3(-1,0,0),deg2rad(-akc.y/8))
#		Birdo.rotate_object_local(Vector3(0,0,1),deg2rad(akc.y/8))
#	print(str(x)+", "+str(y)+", "+str(z))
	if y <= -0.2:
		movo -= Birdo.get_global_transform().basis.z.normalized() * exp(-y)*rapido/2
		rapido -= a
	else:
		movo -= Birdo.get_global_transform().basis.z.normalized() * exp(y)*rapido*3
		rapido += a
	if Input.is_action_pressed("flugi"):
		movo += Birdo.get_global_transform().basis.y.normalized() * rapido/3-\
				Birdo.get_global_transform().basis.z.normalized() * rapido
		rapido += a*2
		if y <= -0.25:
			if rapido > 20:
				rapido = lerp(rapido, 23, 0.4)
		else:
			if rapido > 30:
				rapido = lerp(rapido, 32, 0.4)
	else:
		rapido -= a/3
		if y <= 0:
			if rapido > 15:
				rapido = lerp(rapido, 18, 0.4)
		else:
			if rapido > 20:
				rapido = lerp(rapido, 23, 0.4)
	Birdo.move_and_slide(movo, Vector3( 0, 0, 0 ), 0.05, 6, 0.785398)
	Birdo.move_and_collide(Vector3(0,-0.06,0))
#	print(rapido)
	if rapido < 4:
		rapido = 4
