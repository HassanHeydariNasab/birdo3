extends Area

func _ready():
	set_process(true)

func _process(delta):
	rotate_object_local(Vector3(0,1,0), 0.08)

func _on_Cube_body_entered(body):
	G.cubes += 1
	queue_free()
