extends Spatial

var Bullet = preload('res://Bullets/Bullet1.tscn')

func _ready():
	pass


func _on_Area_body_entered(body):
	$Reload.start()


func _on_Reload_timeout():
	var Bullet_ = Bullet.instance()
	var target = get_node('/root/Main/Bird'
	).get_global_transform().origin
	Bullet_.look_at_from_position(get_global_transform().origin,target, Vector3(1,-1,-1))
	get_node('/root/Main/Bullets').add_child(Bullet_)


func _on_Area_body_exited(body):
	$Reload.stop()