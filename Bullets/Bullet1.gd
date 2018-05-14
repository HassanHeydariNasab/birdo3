extends Spatial


func _ready():
	set_process(true)

func _process(delta):
	global_translate(get_global_transform().basis.z.normalized()*-25)


func _on_Lifetime_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.get_name() == 'Bird':
		G.life -= 1
		if G.life <= 0:
			get_tree().reload_current_scene()
	else:
		queue_free()