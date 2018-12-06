extends KinematicBody

onready var Anim = get_node("Model/AnimationPlayer")
onready var os = OS.get_name()
onready var Croak_1 = get_node("Croak_1")
onready var Croak_2 = get_node("Croak_2")
onready var Croak_3 = get_node("Croak_3")
onready var Croaks = [Croak_1, Croak_2, Croak_3]
onready var Flap_1 = get_node("Flap_1")
onready var Flap_2 = get_node("Flap_2")
onready var Flaps = [Flap_1, Flap_2]
onready var Wind = get_node("Wind")
onready var Collision_1 = get_node("Collision_1")
onready var Collision_2 = get_node("Collision_2")
onready var Collisions = [Collision_1, Collision_2]

var movector = Vector3(0,0,0)
const angle_speed = 0.016
const SPEED = 12
var speed = 12
const a = 0.01

var is_showing_air = true

var Collision_is_played = false

func _ready():
	Anim.play("open_wings")
	$Air_fade.play('fade_in')
	set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _process(delta):
	if Input.is_action_just_pressed("fly"):
		if is_showing_air:
			is_showing_air = false
			$Air_fade.play_backwards('fade_in')
		
	elif Input.is_action_pressed("fly"):
		if not Flap_1.is_playing() and not Flap_2.is_playing():
			randomize()
			Flaps[randi() % 2].play(0.3)
		Wind.set_volume_db(lerp(Wind.get_volume_db(), speed-50, 0.5))
		if Anim.get_current_animation() != "fly2":
			if G.energy >= 1:
				Anim.play("fly2", 0.5, 2)
				
	elif Input.is_action_just_released("fly"):
		if get_translation().y > 200:
			is_showing_air = true
			$Air_fade.play('fade_in', 0.7, 0.3, false)
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
		Wind.set_volume_db(lerp(Wind.get_volume_db(), speed-45, 0.3))
		if not (Input.is_action_pressed("up") or Input.is_action_pressed("down")):
			Flap_1.stop()
			Flap_2.stop()
			if Anim.get_current_animation() != "open_wings":
				Anim.play("open_wings")

#	var height = translation.y
#	#print(height)
#	var albedo = $Air_center.material_override.get_albedo()
#	#$Air_center.material_override.set_albedo(Color(0.7, 0.92, 0.95))
#	print(albedo.a)
#	albedo.a -= height/100000.0
#	if albedo.a <= 0:
#		albedo.a = 0
#	$Air_center.material_override.set_albedo(Color(albedo.r, albedo.g, albedo.b, albedo.a))

func _input(event):
	if event.is_action_pressed("croak"):
		if not (Croak_1.is_playing() or Croak_2.is_playing()):
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
	if os == "Android":
		var akc = Input.get_accelerometer()
#		print(akc)
		rotate_object_local(Vector3(-1,0,0),deg2rad((akc.y+4)/8))
		rotate_object_local(Vector3(0,0,1),deg2rad(-akc.x/8))
#	print(str(x)+", "+str(y)+", "+str(z))
#	print(str(speed)+'	'+str(y))
	if Input.is_action_pressed("fly"):
		if G.energy >= 1:
			G.energy -= 1
			movector += get_global_transform().basis.y.normalized() * speed/2-\
					get_global_transform().basis.z.normalized() * speed
			speed += a*8
	if y <= 0.07:
		movector -= get_global_transform().basis.z.normalized() * exp(-y)*speed
		speed -= (a+abs(y)/10.0)
		if speed > 35.0:
			speed = 35.0
		elif speed < 10.0:
			speed = 10.0
	else:
		movector -= get_global_transform().basis.z.normalized() * exp(y)*speed
		speed += (a+abs(y)/10.0)
		if speed > 35.0:
			speed = 35.0
	
	move_and_slide(movector, Vector3( 0, 0, 0 ), 0.05, 2, 0.785398)
	if is_on_wall() or is_on_ceiling() or is_on_floor():
		speed = lerp(speed, SPEED, 0.1)
		if not Collision_is_played and not (Collision_1.is_playing() or Collision_2.is_playing()):
			randomize()
			Collisions[int(rand_range(0,2))].play()
			Collision_is_played = true
	else:
		Collision_is_played = false
	move_and_collide(Vector3(0,-0.06,0))