extends Spatial

var target = Vector3(0,0,0)

func _ready():
	set_process(true)

func _process(delta):
#	global_translate(target*5)
#	print(get_global_transform().origin)
	global_translate(-get_global_transform().basis.z.normalized()*10)


func _on_Lifetime_timeout():
	queue_free()
