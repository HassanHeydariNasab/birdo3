extends KinematicBody

onready var Anim = get_node("Model/animation_player")
onready var os = OS.get_name()
onready var Croak_1 = get_node("Croak_1")
onready var Croak_2 = get_node("Croak_2")
onready var Croak_3 = get_node("Croak_3")
onready var Croaks = [Croak_1, Croak_2, Croak_3]
onready var Flap_1 = get_node("Flap_1")
onready var Flap_2 = get_node("Flap_2")
onready var Flaps = [Flap_1, Flap_2]
onready var Wind = get_node("Wind")

var movector = Vector3(0,0,0)
const angle_speed = 0.025
const SPEED = 12
var speed = 12
const a = 0.01

func _ready():
	Anim.play("open_wings")
	set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("fly"):
		Wind.set_volume_db(lerp(Wind.get_volume_db(), speed-45, 0.5))
		if Anim.get_current_animation() != "fly":
			Anim.play("fly")
	elif Input.is_action_just_released("fly"):
		Flap_1.stop()
		Flap_2.stop()
		Anim.play("open_wings")
		if Input.is_action_pressed("up"):
			Anim.play("open_wings_up")
		elif Input.is_action_pressed("down"):
			Anim.play("open_wings_down")
	elif Input.is_action_just_pressed("up"):
		Anim.play("open_wings_up")
	elif Input.is_action_just_pressed("down"):
		Anim.play("open_wings_down")
	elif not Input.is_action_pressed("fly"):
		Wind.set_volume_db(lerp(Wind.get_volume_db(), speed-33, 0.3))
		if not (Input.is_action_pressed("up") or Input.is_action_pressed("down")):
			Flap_1.stop()
			Flap_2.stop()
			if Anim.get_current_animation() != "open_wings":
				Anim.play("open_wings")

func _input(event):
	if event.is_action_pressed("croak"):
		randomize()
		Croaks[int(rand_range(0,3))].play()

func _physics_process(delta):
	if translation.y < 7:
		translation.y = 7
	if Input.is_action_pressed("up"):
		rotate_object_local(Vector3(-1,0,0), angle_speed)
	if Input.is_action_pressed("down"):
		rotate_object_local(Vector3(1,0,0), angle_speed)
	if Input.is_action_pressed("right"):
		rotate_object_local(Vector3(0,0,-1), angle_speed)
	if Input.is_action_pressed("left"):
		rotate_object_local(Vector3(0,0,1), angle_speed)
	if Input.is_action_pressed("right2"):
		rotate_object_local(Vector3(0,-1,0), angle_speed/3)
	if Input.is_action_pressed("left2"):
		rotate_object_local(Vector3(0,1,0), angle_speed/3)
	movector = Vector3(0,0,0)
	var t = get_transform().basis.z.normalized()
	var x = t.x
	var y = t.y
	var z = t.z
#	if os == "Android":
#		var akc = Input.get_accelerometer()
#		rotate_object_local(Vector3(-1,0,0),deg2rad(-akc.y/8))
#		rotate_object_local(Vector3(0,0,1),deg2rad(akc.y/8))
#	print(str(x)+", "+str(y)+", "+str(z))
	if y <= -0.2:
		movector -= get_global_transform().basis.z.normalized() * exp(-y)*speed/2
		speed -= a
	else:
		movector -= get_global_transform().basis.z.normalized() * exp(y)*speed*3
		speed += a
	if Input.is_action_pressed("fly"):
		movector += get_global_transform().basis.y.normalized() * speed/3-\
				get_global_transform().basis.z.normalized() * speed
		speed += a*2
		if y <= -0.25:
			if speed > 20:
				speed = lerp(speed, 23, 0.4)
		else:
			if speed > 30:
				speed = lerp(speed, 32, 0.4)
	else:
		speed -= a/3
		if y <= 0:
			if speed > 15:
				speed = lerp(speed, 18, 0.4)
		else:
			if speed > 20:
				speed = lerp(speed, 23, 0.4)
	move_and_slide(movector, Vector3( 0, 0, 0 ), 0.05, 6, 0.785398)
	move_and_collide(Vector3(0,-0.06,0))
#	print(speed)
	if speed < 4:
		speed = 4