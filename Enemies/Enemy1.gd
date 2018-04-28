extends Spatial

var Bullet = preload('res://Bullets/Bullet1.tscn')

func _ready():
	pass


func _on_Area_body_entered(body):
	$Reload.start()


func _on_Reload_timeout():
	var Bullet_ = Bullet.instance()
	get_node('/root/Main/Bullets').add_child(Bullet_)
	var target = get_node('/root/Main/Bird'
		).get_global_transform().origin
	Bullet_.look_at_from_position(self.get_global_transform().origin,
		target, Vector3(-1,0,0))


func _on_Area_body_exited(body):
	$Reload.stop()