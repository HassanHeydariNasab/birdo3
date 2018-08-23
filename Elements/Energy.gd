extends Area

func _ready():
	pass

func _on_Cube_body_entered(body):
	G.energy += 5000
	queue_free()
