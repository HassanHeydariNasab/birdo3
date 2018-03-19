extends KinematicBody

onready var Birdo = get_node(".")
onready var Animo = get_node("Bird/animation_player")
onready var os = OS.get_name()

var rapido = Vector3(0,0,0)
const angula_rapido = 0.03

func _ready():
	Animo.play("flugi")
	set_process(true)
	set_physics_process(true)
#	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("flugi"):
		if Animo.get_current_animation() != "flugi":
			Animo.play("flugi")
	else:
		Animo.play("malfermaj_flugiloj")

#func _input(evento):
#	pass

func _physics_process(delta):
	if Input.is_action_pressed("supre"):
		Birdo.rotate_object_local(Vector3(-1,0,0),angula_rapido)
#		Birdo.rotate(Vector3(-1,0,0),angula_rapido)
#		Birdo.rotate_x(-angula_rapido)
	if Input.is_action_pressed("malsupre"):
		Birdo.rotate_object_local(Vector3(1,0,0),angula_rapido)
#		Birdo.rotate_x(angula_rapido)
	if Input.is_action_pressed("dekstre"):
		Birdo.rotate_object_local(Vector3(0,0,-1),angula_rapido)
#		Birdo.rotate_z(-angula_rapido)
	if Input.is_action_pressed("maldekstre"):
		Birdo.rotate_object_local(Vector3(0,0,1),angula_rapido)
#		Birdo.rotate_z(angula_rapido)
	if Input.is_action_pressed("dekstre2"):
		Birdo.rotate_object_local(Vector3(0,-1,0),angula_rapido)
#		Birdo.rotate_y(-angula_rapido)
	if Input.is_action_pressed("maldekstre2"):
		Birdo.rotate_object_local(Vector3(0,1,0),angula_rapido)
#		Birdo.rotate_y(angula_rapido)
	rapido = Vector3(0,0,0)
	var t = Birdo.get_transform().basis.z.normalized()
	var x = t.x
	var y = t.y
	var z = t.z
#	if os == "Android":
#		var akc = Input.get_accelerometer()
#		Birdo.rotate_z(deg2rad(akc.x/8))
#		Birdo.rotate_x(deg2rad(-akc.y/8))
#	print(str(x)+", "+str(y)+", "+str(z))
	if y <= 0:
		rapido -= Birdo.get_global_transform().basis.z.normalized() * exp(-y)*5
	else:
		rapido -= Birdo.get_global_transform().basis.z.normalized() * exp(y)*10
	if Input.is_action_pressed("flugi"):
		rapido += Birdo.get_global_transform().basis.y.normalized() * 3-\
			Birdo.get_global_transform().basis.z.normalized() * 15
#	Birdo.set_linear_velocity(rapido)
	Birdo.move_and_collide(rapido/100)
	Birdo.translate(Vector3(0,-0.03,0))
