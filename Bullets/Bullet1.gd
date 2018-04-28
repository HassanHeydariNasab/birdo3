extends Spatial


func _ready():
	set_process(true)

func _process(delta):
	move_and_collide(get_global_transform().basis.z.normalized()*-10)


func _on_Lifetime_timeout():
	queue_free()