extends KinematicBody

var Bullet = preload('res://Bullets/Bullet1.tscn')
onready var Shoot = get_node('Shoot')

func _ready():
	set_process(true)


func _process(delta):
	var target = get_node('/root/Main/Bird'
		).get_global_transform().origin
	look_at_from_position(self.get_global_transform().origin,
		target, Vector3(-1,0,0))
	randomize()
	target += Vector3(rand_range(-1000,1000), rand_range(-1000,1000),
						rand_range(-1000,1000))
	if self.get_global_transform().origin.distance_to(target) > 150:
		move_and_slide(get_global_transform().basis.z.normalized()*-50)


func _on_Area_body_entered(body):
	$Reload.start()


func _on_Reload_timeout():
	var Bullet_ = Bullet.instance()
	get_node('/root/Main/Bullets').add_child(Bullet_)
	var target = get_node('/root/Main/Bird'
		).get_global_transform().origin
	var distance = get_global_transform().origin.distance_to(target)
	randomize()
	var error = rand_range(-distance/10,distance/10)
	print(error)
	target += Vector3(error, error, error)
	Bullet_.look_at_from_position(self.get_global_transform().origin,
		target, Vector3(-1,0,0))
	Shoot.play()


func _on_Area_body_exited(body):
	$Reload.stop()