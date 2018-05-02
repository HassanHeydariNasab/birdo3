extends Spatial


func _ready():
	set_process(true)

func _process(delta):
	global_translate(get_global_transform().basis.z.normalized()*-25)


func _on_Lifetime_timeout():
	queue_free()