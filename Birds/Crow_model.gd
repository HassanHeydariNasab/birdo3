extends Spatial

func _ready():
	pass

func _on_animation_player_animation_started(anim_name):
	if anim_name == "fly":
		randomize()
		get_node("..").Flaps[rand_range(0,2)].play()